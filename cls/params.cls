<?php
class Params{
var $id;
var $doc_id;
var $param_type;
var $item;
var $value;

var $tbl;
var $arr;
function __construct(){
    $this->id=0;
    $this->doc_id=0;
    $this->param_type='';
    $this->item=0;
    $this->value=0;
    $this->tbl="params";
    
    $this->LastErr=0;
}

function __destruct() {
}
 

function Save(){
    global $mdb;
    $this->LastErr=0;
    if(!$this->id){$this->Insert();return;}
    $lstr= "name='".$this->name."'";
    $lstr.= ",descr='".$this->descr."'";
    $lstr.= ",user_id=".$this->user_id;
    $lstr.= ",cols=".$this->cols;
    $lstr.= ",rows=".$this->rows;
    $lsql="UPDATE ".$this->tbl." SET ".$lstr." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}

function find($doc){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl;
    $mdb->do_query($lsql);
    $this->arr=array();
    $this->arr[0]=0;
    while($ret=$mdb->GetRow()){
        $this->arr[0]++;
        $this->arr[$this->arr[0]]=$ret['id'];
    }
    //var_dump($this->arr);exit;
    return($this->arr[0]);
}

function Insert(){
    global $mdb;
    $lcol="doc_id,param_type,item,value";
    $lstr= "'".$this->doc_id."'";
    $lstr.= ",'".$this->param_type."'";
    $lstr.= ",".$this->item;
    $lstr.= ",".$this->value;
    $lsql="INSERT INTO ".$this->tbl."(".$lcol.") VALUES(".$lstr.")";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
        return($this->id);
    }
    return(0);
}
}
?>
