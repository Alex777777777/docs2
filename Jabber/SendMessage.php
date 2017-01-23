<?php

// activate full error reporting
error_reporting(E_ERROR);

include 'XMPP.php';

#Use XMPPHP_Log::LEVEL_VERBOSE to get more logging for error reports
#If this doesn't work, are you running 64-bit PHP with < 5.2.6?
function OverviewMessage($message, $url, $f_user, $jabber) {
    //Cnage data
	global $param;
	
    $user = $param->arr["JLOGON"];
    $password = $param->arr["JPASS"];
    $host = $param->arr["JHOST"];
    $server= $param->arr["JSERVER"];
    $to = $jabber;//'tyrmen@jabber.ccc.de';
    //---
		
	$conn = new XMPPHP_XMPP($server, 5222, $user, $password, 'xmpphp', $host , $printlog=false, $loglevel=XMPPHP_Log::LEVEL_INFO);
	
	
	$message_to_jabber = $message;
	//$message_to_jabber = 'User: ' . $f_user . ', Message: ' . $message . ', url: ' . $url;

	try {
		$conn->connect();
		$conn->processUntil('session_start');
		$conn->presence();
		$conn->message($to, $message_to_jabber);
		$conn->disconnect();
	} catch(XMPPHP_Exception $e) {
		die($e->getMessage());
	}
}
