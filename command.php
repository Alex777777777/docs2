<?php
session_start();
$PathLoc=__DIR__;
$mdb=require("cls/db_class.cls");
$mdb->OpenDB();
require("cls/shell_user.cls");
$tuser="";$tpass="";
if(isset($_SESSION['user']))$tuser=$_SESSION['user'];
if(isset($_SESSION['pass']))$tpass=$_SESSION['pass'];
if(!$tuser)header("Location: ").$_SERVER["HTTP_HOST"];
$user=new ShellUser();
$user->Open($tuser,$tpass);
$user->Validate($tpass);
if(!$user->valid){echo "0";exit;}
if(isset($_POST["tpl"])){
    $ret="command/".$_POST["tpl"].".tpl";
    require($ret);
}else echo "0";
?>
