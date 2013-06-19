<?php
/**
 * Configuration settings for demonstration
 * 
 */

class OAuthDemoConfig {

    /**
     * @return array config settings 
     */
    public static function getConfig(){
        return array(
            'debug' => true,
            'tokenSaveLocation' => '/tmp/oauth.token', // directory/filename of token **REPLACE**
            'resourceLogin' => 'http://domain/login/oauth',
            'username' => 'steve', // account username located in the central authentication resource 
            'password' => 'test123'
            );
    }
}
