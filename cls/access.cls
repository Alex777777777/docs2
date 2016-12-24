<?php
class Access{
var $id;
var $doc;
var $row;
var $col;
var $user;
var $date;
var $flag;

var $LastErr;
var $tbl;
function __construct(){
    $this->id=0;
    $this->doc=0;
    $this->row=0;
    $this->col=0;
    $this->user=0;
    $this->date=0;
    $this->flag=0;
    
    $this->LastErr=0;
    $this->tbl="access";
}

function __destruct() {
}
function Create(){
    global $mdb;
    global $user;
    $this->id=0;
    $lsql="INSERT INTO $this->tbl (doc,row,col,user) VALUES(";
    $lsql.= "$this->doc ,";
    $lsql.= "$this->row ,";
    $lsql.= "$this->col ,";
    $lsql.= "$user->id ) ";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->id=mysqli_insert_id($mdb->lCon);
        $this->user=$user-id;
    }
}
function Get(){
    global $mdb;
    global $user;
    $this->id=0;
    $lsql="UPDATE $this->tbl SET flag=0 WHERE ((user=".$user->id.")AND(flag=1))";
    $mdb->do_query($lsql);
    $lsql="SELECT id, date, user, flag FROM $this->tbl WHERE (";
    $lsql.= "(doc=$this->doc) AND";
    $lsql.= "(row=$this->row) AND";
    $lsql.= "(col=$this->col))";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $row=$mdb->GetRow();
        if($row){
            $this->id=0+$row["id"];
            $this->date=$row["date"];
            $this->user=$row["user"];
            $this->flag=0+$row["flag"];
        }else $this->Create();
    }
}
function Lock(){
    global $mdb;
    global $user;
    $lsql="UPDATE $this->tbl SET flag=1,user=".$user->id." WHERE id=".$this->id;
    $mdb->do_query($lsql);
}
function UnLock(){
    global $mdb;
    $lsql="UPDATE $this->tbl SET flag=0 WHERE id=".$this->id;
    $mdb->do_query($lsql);
}
function GetCell($obj){
    $this->doc=$obj->doc_id;
    $this->row=$obj->row;
    $this->col=$obj->col;
    $this->Get();
}
function ClearLock($lusr=0){
    global $mdb;
    $lsql="UPDATE $this->tbl SET flag=0 WHERE ((flag=1)AND(date<(NOW()-3000)))";
    $mdb->do_query($lsql);
    if($lusr){
        $lsql="UPDATE $this->tbl SET flag=0 WHERE ((flag=1)AND(user=".$lusr."))";
        $mdb->do_query($lsql);
    };
}
}
?>
