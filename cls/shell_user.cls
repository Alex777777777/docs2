<?php
class ShellUser{
var $id;
var $login;
var $pass;
var $role;
var $valid;
var $jabber;
var $apikey;

var $LastErr;
var $Err_Descr;
var $arr;
var $authing;
var $tbl;
function __construct(){
    $this->id=0;
    $this->pass="";
    $this->login="";
    $this->role=0;
    $this->valid=0;
    $this->jabber="";
    $this->apikey="";
    $this->LastErr=0;
    $this->jobs=0;
    $this->authing=0;
    $this->tbl="users";
}
function __destruct() {
}
function GetRole(){
    $ret="";
    switch($this->role){
        case 0:
            $ret="Заморожен";
        break;
        case 1:
            $ret="Администратор";
        break;
        case 9:
            $ret="Пользователь";
        break;
        default:
            $ret="Не активен";
    }
    return($ret);
}
function Select(){
    global $mdb;
    $lsql="SELECT id FROM ".$this->tbl;
    $mdb->do_query($lsql);
    $this->arr=array();
    $this->arr[0]=0;
    while($ret=$mdb->GetRow()){
        $this->arr[0]++;
        $this->arr[$this->arr[0]]=$ret['id'];
    }
    return($this->arr[0]);
}
function Open($luser, $lpass){
    global $mdb;
    $this->id=0;
    $this->pass="";
    $this->login="";
    $this->role=0;
    $this->valid=0;
    $this->jabber="";
    $this->apikey="";
    $this->LastErr=0;
    $luser=strtolower($luser);
    $lsql="SELECT * FROM ".$this->tbl." WHERE login='$luser'";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->pass=$ret["pass"];
            $this->login=$ret["login"];
            $this->role=$ret["role"];
            $this->jabber=$ret["jabber"];
            $this->apikey=$ret["apikey"];
            $ppass=$lpass;
            if($this->authing)$ppass=md5($lpass);
            if($this->pass==$ppass){
                $this->valid=1;
            }
            $this->pass="".crc32($this->pass);
            if(!$this->valid){$this->LastErr=100;return;}
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
}
function Frozen($lid){
    global $mdb;
    $this->LastErr=1;
    $lsql="UPDATE ".$this->tbl." SET role=0 WHERE id=".$lid;
    $mdb->do_query($lsql);
    if($mdb->LastErr)$this->LastErr=0;
}
function Delete($lid){
    global $mdb;
    $this->LastErr=1;
    $lsql="DELETE FROM ".$this->tbl." WHERE id=".$lid;
    $mdb->do_query($lsql);
    if($mdb->LastErr)$this->LastErr=0;
}
function GetItem($lid){
    global $mdb;
    $this->id=0;
    $this->pass="";
    $this->login="";
    $this->role=0;
    $this->valid=0;
    $this->jabber="";
    $this->LastErr=0;
    $lsql="SELECT * FROM ".$this->tbl." WHERE id=$lid";
    $mdb->do_query($lsql);
    $this->LastErr=1;
    if($mdb->LastErr){
        $ret=$mdb->GetRow();
        if($ret){
            $this->id=$ret["id"];
            $this->login=$ret["login"];
            $this->role=$ret["role"];
            $this->jabber=$ret["jabber"];
            $this->apikey=trim($ret["apikey"]);
            $this->LastErr=0;
        }else $this->LastErr=2;    
    }
}
function Save(){
    global $mdb;
    $this->LastErr=1;
    $this->login=strtolower($this->login);
    if(!$this->id){$this->Insert();return;}
    $lstr= "login='".$this->login."'";
    $lstr.= ",jabber='".$this->jabber."'";
    $lstr.= ",apikey='".$this->apikey."'";
    if($this->pass)$lstr.= ",pass='".md5($this->pass)."'";
    $lstr.= ",role=".$this->role;
    $lsql="UPDATE ".$this->tbl." SET ".$lstr." WHERE id=".$this->id;
    $mdb->do_query($lsql);
    if($mdb->LastErr)$this->LastErr=0;
}
function Insert(){
    global $mdb;
    $this->LastErr=1;
    $lcol="login,jabber,apikey,pass,role";
    $lstr= "'".$this->login."'";
    $lstr.= ",'".$this->jabber."'";
    $lstr.= ",'".$this->apikey."'";
    if($this->pass)$lstr.= ",'".md5($this->pass)."'";
    $lstr.= ",".$this->role;
    $lsql="INSERT INTO ".$this->tbl."(".$lcol.") VALUES(".$lstr.")";
    $mdb->do_query($lsql);
    if($mdb->LastErr){
        $this->LastErr=0;
        $this->id=mysqli_insert_id($mdb->lCon);
    }
}
function Validate($par){
    $this->valid=0;
    if(!$par)return;
    if($this->pass==$par){
        $this->valid=1;
        $this->LastErr=0;
    }else {
        $this->valid=0;
        $this->LastErr=100;
    }
}
}
?>
