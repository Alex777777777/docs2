<?php
if($user->role!="1"){
    echo "0";
    exit;
}
$obj=new ShellUser();
$obj->Frozen($_POST["id"]);
if(!$obj->LastErr)echo "0";
else echo "1";
?>
