<?php
if($user->role>2){
    echo "9";
    exit;
};
  $pukey=$_POST["pukey"];
  $prkey=$_POST["prkey"];
  $tm1=$PathLoc."/cls/cript.ini";
  if(!file_exists($tm1)){
    $arr="{
        \"cript\":0,
        \"hesh\":0
    }";
    file_put_contents($fpath,$arr);
  };
  $cr_data=file_get_contents($tm1);
  $cr=json_decode($cr_data,true);
  if($cr["cript"]){
    if(crc32($pukey)!=$cr["hesh"]){echo "8";exit;}
  }
  require("cls/docs.cls");
  require("cls/item.cls");
  $obj=new Docs(); 
  echo $obj->recript($pukey,$prkey);
?>
