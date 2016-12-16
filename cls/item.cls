<?php
class Cell{
var $id;
var $doc_id;
var $row;
var $col;
var $item_id;
var $value;
var $LastErr;
var $tbl;
function __construct(){
    $this->id=0;
    $this->doc_id=0;
    $this->row=0;
    $this->col=0;
    $this->item_id=0;
    $this->value="";
    $this->LastErr=0;
    $this->tbl="cells";
}

function __destruct() {
}
function GetCell($ldoc,$lrow,$lcol){
    global $mdb;
    $this->id=0;
    $this->doc_id=0;
    $this->row=0;
    $this->col=0;
    $this->item_id=0;
    $this->LastErr=0;
    $lsql="SELECT * FROM ".$this->tbl." WHERE ((doc_id=$ldoc)AND(row=$lrow)AND(col=$lcol))";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->doc_id=$ret["doc_id"];
            $this->row=$ret["row"];
            $this->col=$ret["col"];
            $this->item_id=$ret["item_id"];
            $lit=new Item();
            $this->value=$lit->GetValue($this->item_id);
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
}
}
class Item{
    var $id;
    var $time;
    var $value;
    var $cell_id;
    var $LastErr;
    var $tbl;
    function __construct(){
        $this->id=0;
        $this->time=0;
        $this->value=0;
        $this->cell_id=0;
        $this->LastErr=0;
        $this->tbl="items";
    }

    function __destruct() {
    }
    function GetValue($lid){
        global $mdb;
        $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
        $mdb->do_query($lsql);
        if($mdb->LastErr){
            $ret=$mdb->GetRow();
            if($ret){
                return($ret["value"]);
            }else return("");
        }else return("");
    }
}
?>
