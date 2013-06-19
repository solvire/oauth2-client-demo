# OAuth 2.0 End-User Client Demo

- - - 

#### About 
At United Sample Inc. an initiative is in place to use the OAuth 2.0 Authorization framework / protocol to provide part of the security layer for the various products.  
This application is intended to be used in conjunction with the [Client](https://github.com/php-loep/oauth2-client) 
and [Server](https://github.com/php-loep/oauth2-server) applications provided by [The League of Extraordinary Packages](https://github.com/php-loep). 
Both were forked internally to uSamp but still retain almost all the original infrastructure.  Pull requests will be made once we have
vetted the application in a production environment.  

#### Implementation Goal
The intention is for an implementation of [RFC6749](http://tools.ietf.org/html/rfc6749 "RFC6749") end-user or the owner of the resource. 
The client is an internal application that needs an OAuth server to vouch for the Authorization of the client. 

This is an incredibly simple tool to show and implement the flow of OAuth authorization.  

<img src="images/OAuth2.jpg" alt="OAuth 2 logo" />

See: (http://oauth.net/)

See: (http://tools.ietf.org/html/rfc6749)  


#### Audience
Clients of United Sample OAuth enabled services can utilize this client as a base for setting up their resource consumers.  

#### Terms 
**Resource Owner**

   An entity capable of granting access to a protected resource.
   When the resource owner is a person, it is referred to as an
   end-user.

**Resource Server**

   The server hosting the protected resources, capable of accepting
   and responding to protected resource requests using access tokens.

**Client**

   An application making protected resource requests on behalf of the
   resource owner and with its authorization.  The term "client" does
   not imply any particular implementation characteristics (e.g.,
   whether the application executes on a server, a desktop, or other
   devices).

**Authorization Server**

   The server issuing access tokens to the client after successfully
   authenticating the resource owner and obtaining authorization.
   
### Requirements
 * A PHP 5.3+ environment
 * Guzzle HTTP 
 
 
### Installation 
The suggestion installation method for this application is with Composer. Simply add the following 
your composer.json file:

    {
        "require": {
            "solvire/oauth2-client-demo": "*"
        }
    }

For more information concerning the installation of Composer see [Get Composer](http://getcomposer.org/)

### Usage 

Setting up the config will get you close to where you need to be.  

Then run the command line script *getToken.php*

The expected outcome should be something similar to:

	[usamp@local src]$ php getToken.php 
	Original token: Array
	(
		[accessToken] => Rscx3XZowSPD2HJFFFzJrEFbVzlSTPkSrS49XPwQ
		[expires] => 2743241052
		[refreshToken] => WM6EUcGDdjpxzrWZJdBU4c3Wc1RsQT6oyila7sGH
		[uid] => 
	)

	New Token: Array
	(
		[accessToken] => ruojjj0WDF8CY5OTfEId0abPnYCZHH7v8AmTsOgR
		[expires] => 2743241052
		[refreshToken] => 
		[uid] => 
	)

The above example shows the connection to the system, authentication, authorization and response with the original token. 
The the script will try again with a new connection and get another token by the refresh_token means. 

