<?php
if($user->role>2){
    echo "9";
    exit;
};
  $pukey=$_POST["pukey"];
  $prkey=$_POST["prkey"];
  require("cls/docs.cls");
  require("cls/item.cls");
  $obj=new Docs(); 
  echo $obj->recript($pukey,$prkey);
?>
