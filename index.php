<?php
session_start();
$PathLoc=__DIR__;
$mdb=require("cls/db_class.cls");
$mdb->OpenDB();
require("cls/shell_user.cls");
if(isset($_GET["logout"])){unset($_SESSION['user']);unset($_SESSION['pass']);header("Location: http://".$_SERVER['HTTP_HOST']."/".$_SERVER['SCRIPT_NAME']);exit(1);}
if(isset($_GET["do"]))if($_GET["do"]=="auth"){require("tpl/auth.php");exit(1);}
$tuser="";$tpass="";
if(isset($_SESSION['user']))$tuser=$_SESSION['user'];
if(isset($_SESSION['pass']))$tpass=$_SESSION['pass'];
$user=new ShellUser();
$user->Open($tuser,$tpass);
$user->Validate($tpass);
if(!$user->valid){require("tpl/auth.php");}
else require("tpl/loader.php");
?>
