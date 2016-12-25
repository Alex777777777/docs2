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
function GetCell(){
    global $mdb;
    $this->id=0;
    $this->item_id=0;
    $this->LastErr=1;
    $lsql="SELECT * FROM ".$this->tbl." WHERE ((doc_id=".$this->doc_id.")AND(row=".$this->row.")AND(col=".$this->col."))";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->doc_id=$ret["doc_id"];
            $this->row=$ret["row"];
            $this->col=$ret["col"];
            $this->item_id=$ret["item_id"];
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
}
function GetValue(){
    global $mdb;
    if(!$this->item_id){$this->value="";return;}
    $item=new Item();
    $this->value=$item->GetValue($this->item_id);
}
function Save(){
    global $mdb;
    if(!$this->id)$this->NewCell();
    $item=new Item();
    $item->cell_id=$this->id;
    $item->value=$this->value;
    $item->Add();
    $this->item_id=$item->id;
    $lsql="UPDATE ".$this->tbl." SET item_id=".$this->item_id ." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
    }
}
function NewCell(){
    global $mdb;
    $lsql="INSERT INTO ".$this->tbl."(row,col,doc_id) VALUES(".$this->row.",".$this->col.",".$this->doc_id.")";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
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
    function GetMaxItem(){
        global $mdb;
        $lsql="SELECT MAX(id)as mid FROM ".$this->tbl;
        $mdb->do_query($lsql);
        if($mdb->LastErr){
            $ret=$mdb->GetRow();
            if($ret){
                return($ret["mid"]);
            }else return("0");
        }else return("0");
    }
    function GetValue($lid){
        global $mdb;
        $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
        $mdb->do_query($lsql);
        if($mdb->LastErr){
            $ret=$mdb->GetRow();
            if($ret){
                $this->id=$ret['id'];
                $this->time=$ret['time'];
                $this->value=$ret['value'];
                $this->cell_id=$ret['cell_id'];
                return($ret["value"]);
            }else return("");
        }else return("");
    }
    function Add(){
        global $mdb;
        global $user;
        $lsql="INSERT INTO  ".$this->tbl."(value,cell_id,user) VALUES('".$this->value."',".$this->cell_id.",".$user->id.")";
        $mdb->do_query($lsql);
        if($mdb->LastErr){
            $this->id=mysqli_insert_id($mdb->lCon);
            $this->LastErr=0;
        }else{
            $this->LastErr=2;
        }
    }
}
?>
