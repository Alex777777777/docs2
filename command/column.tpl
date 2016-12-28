<?php
$ldo=$_POST["do"];
switch($ldo){
    case "colup":
        require("cls/params.cls");
        $obj=new Params();
        if(isset($_POST['val'])){
            foreach($_POST['val'] as $key => $value){
                 $obj->doc_id=1;
                 $obj->param_type='colWidth';
                 $obj->item=$key;
                 $obj->value=$value;
                 $obj->Insert();
            } 
        }
    break;
}

if($obj->LastErr)echo "0";
else echo "1";
?>