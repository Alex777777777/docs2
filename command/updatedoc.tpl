<?php
require($PathLoc."/cls/item.cls");
$items=new Item();
$lid=$_POST["id"];
$did=$_POST["doc"];
$lsql="SELECT items.id AS id, items.time as date, items.value AS val, users.login AS user, cells.row AS row, cells.col as col,docs.id as doc
FROM items 
  INNER JOIN cells ON items.cell_id=cells.id 
  INNER JOIN docs  ON cells.doc_id = docs.id
  LEFT JOIN users ON  items.user = users.id 
WHERE (items.id>$lid) AND (docs.id=$did)ORDER BY items.id";
$mdb->do_query($lsql);
$ret=array();
if($mdb->LastErr){
    $arr=array();
    while($ret=$mdb->GetRow()){
        $arr[]=$ret;    
    }
    $ret["data"]=$arr;
    $ret["stat"]="OK";
}else $ret["stat"]="ER";

echo json_encode($ret);

?>
