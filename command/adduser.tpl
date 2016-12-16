<?php
if($user->role!=1){
    echo "0";
    exit;
}
$obj=new ShellUser();
$obj->id=$_POST["id"];
$obj->login=$_POST["name"];
$obj->jabber=$_POST["jabb"];
$obj->apikey=$_POST["apikey"];
$obj->role=$_POST["role"];
$obj->lang=$_POST["lang"];
if($_POST["ispass"])
    $obj->pass=$_POST["pass"];
$obj->Save();
if(!$obj->LastErr)echo "0";
else echo "1";
?>
