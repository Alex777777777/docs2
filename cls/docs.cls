<?php
class Docs{
var $id;
var $name;
var $descr;
var $user_id;
var $cols;
var $rows;

var $LastErr;
var $Err_Descr;
var $arr;
var $tbl;
function __construct(){
    $this->id=0;
    $this->name="";
    $this->descr="";
    $this->user_id=0;
    $this->cols=0;
    $this->rows=0;
    $this->LastErr=0;
    $this->tbl="docs";
}
function __destruct() {
}
function Select($par=0){
    global $mdb;
    $this->LastErr=0;
    $lsql="SELECT id FROM ".$this->tbl." WHERE (unlink=0)AND(user_id=".$par.")";
    $mdb->do_query($lsql);
    $this->arr=array();
    $this->arr[0]=0;
    while($ret=$mdb->GetRow()){
        $this->arr[0]++;
        $this->arr[$this->arr[0]]=$ret['id'];
    }
    return($this->arr[0]);
}
function GetItem($lid){
    global $mdb;
    $this->id=0;
    $this->name="";
    $this->descr="";
    $this->user_id=0;
    $this->cols=0;
    $this->rows=0;

    $this->LastErr=0;
    $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->name=$ret["name"];
            $this->descr=$ret["descr"];
            $this->user_id=$ret["user_id"];
            $this->cols=$ret["cols"];
            $this->rows=$ret["rows"];
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
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
function Insert(){
    global $mdb;
    $this->LastErr=1;
    $lcol="name,descr,user_id,cols,rows";
    $lstr= "'".$this->name."'";
    $lstr.= ",'".$this->descr."'";
    $lstr.= ",".$this->user_id;
    $lstr.= ",".$this->cols;
    $lstr.= ",".$this->rows;
    $lsql="INSERT INTO ".$this->tbl."(".$lcol.") VALUES(".$lstr.")";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
        return($this->id);
    }
    return(0);
}
function AddRow(){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET rows=rows+1 WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}
function AddCol(){
    global $mdb;
    $this->LastErr=0;
    $lsql="UPDATE ".$this->tbl." SET cols=cols+1 WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}
function Delete(){
    global $mdb;
    $this->LastErr=0;
    if(!$this->id){$this->LastErr=1;return;}
    $lsql="UPDATE ".$this->tbl." SET unlink=1 WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if(!$mdb->LastErr)$this->LastErr=1;
}
}
?>
