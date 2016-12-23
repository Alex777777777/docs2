<?php
$ldo=$_POST["do"];
switch($ldo){
    case "set":
        require("cls/item.cls");
        $obj=new Cell();
        $lid=json_decode($_POST["id"] ,true);
        $obj->doc_id=$_POST["doc"];
        $obj->row=$lid["row"];
        $obj->col=$lid["col"];
        $obj->GetCell();
        $obj->value=$_POST["val"];
        $obj->Save();
    break;
    case "name":
        require("cls/docs.cls");
        $obj=new Docs();
        $obj->id=1;
        $obj->name=$_POST["name"];
        $obj->descr=$_POST["descr"];
        $obj->cols=0+$_POST["cols"];
        $obj->rows=0+$_POST["rows"];
        $obj->Save();
    break;
}

if($obj->LastErr)echo "0";
else echo "1";
?>
