<?php
require("cls/docs.cls");
$do=$_POST["do"];
switch($do){
    case "new":
        $obj=new Docs();
        $obj->name="Документ";
        $obj->descr="Новый документ";
        $obj->cols=20;
        $obj->rows=30;
        $obj->Save();
        $obj->name="Документ №".$obj->id;
        $obj->Save();
    break;
    case "del":
        $obj=new Docs();
        $obj->id=$_POST["id"];
        $obj->Delete();
    break;
}
if($obj->LastErr)echo "0";
else echo "1";
?>
