<?php
include_once 'OAuthEndUser.php';
include_once 'OAuthDemoConfig.php';
require_once 'Vendors/autoload.php'; // composer vendors + autoloader

$user = new OAuthEndUser(
    OAuthDemoConfig::getConfig()
    );
    
// gets the initial access token 
$token = $user->getAccessToken();

$tokenNew = $user->refreshToken($token['refreshToken']);

echo "Original token: ";
print_r($token);
echo "\nNew Token: ";
print_r($tokenNew) . "\n";

