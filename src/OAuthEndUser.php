<?php
use Guzzle\Http\Client;
use Guzzle\Plugin\Cookie\CookiePlugin;
use Guzzle\Plugin\Cookie\CookieJar\ArrayCookieJar;

/**
 * @author Steven Scott
 */
class OAuthEndUser
{
    protected $guzzleClient = null;
    
    protected $config = null;
    
    /**
     * list of the required config fields 
     * @var array $requiredFields
     */
    protected $requiredFields = array();
    
    public function __construct(array $config)
    {
        $this->config = $config;
        $this->initClient($this->config['resourceLogin']);
    }
    
    /**
     * initialize the the client
     * @param string $uri resource for the client 
     */
    public function initClient($uri)
    {
        $cookiePlugin = new CookiePlugin(new ArrayCookieJar());
        $this->guzzleClient = new Client($uri);
        $this->guzzleClient->addSubscriber($cookiePlugin);
    }
    
    /**
     * @see http://tools.ietf.org/html/rfc6749#section-4.1
     * Auto authorization is enabled for this client 
     */
    public function getAccessToken()
    {
        // call the 
        $loginForm = $this->guzzleClient
            ->get()
            ->setHeader('Accept','application/json')
            ->send();
        $formAsJson = $loginForm->json();
        
        if(!isset($formAsJson['links']['query']['href']))
            throw new RuntimeException("JSON not returned or invalid format");
            
        
        $href = $formAsJson['links']['query']['href'];
        $method = $formAsJson['links']['query']['method'];
        
        $token = $this->guzzleClient
            ->post($href)
            ->addPostFields(
                array(
                    'username' => $this->config['username'],
                    'password' => $this->config['password']
                ))
            ->setHeader('Accept','application/json')
            ->send();
        
        return $token->json();
            
    }
    
    /**
     * Used when the token that is in use has expired 
     * Complies with the section 6 specifications 
     * @see http://tools.ietf.org/html/rfc6749#section-6
     * @param string $refreshToken
     * @return array new token data 
     * 
     * POST
     * required fields
     *  grant_type
     *  refresh_token
     * optional field
     *  scope 
     *  state
     *  
     * example:
     * http://domain/login/oauth?refresh_token=bffAWbCDgnd8Zwbpu6iyhxfEx94iGhrmTte6bfOw&state=&grant_type=refresh_token
     *  
     */
    public function refreshToken($refreshToken)
    {
        
        $this->initClient($this->config['resourceLogin']);
        $token = $this->guzzleClient
            ->get('?refresh_token='.$refreshToken.'&grant_type=refresh_token&state=&scope=')
            ->setHeader('Accept','application/json')
            ->send();
        return $token->json();
        
    }
    

    
}