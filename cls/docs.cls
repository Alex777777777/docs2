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
function GetCriptData(){
    global $PathLoc;
    $fpath=$PathLoc."/cls/cript.ini";
    if(!file_exists($fpath)){
        $arr="{
            \"cript\":0,
            \"hesh\":0
        }";
        file_put_contents($fpath,$arr);
    };
    $par=file_get_contents($fpath);
    $par=json_decode($par,true);
    return($par);
}
function recript($pukey,$prkey){
    global $PathLoc;
    $fpath=$PathLoc."/cls/cript.ini";
    if(!file_exists($fpath)){
        $arr="{
            \"cript\":0,
            \"hesh\":0
        }";
        file_put_contents($fpath,$arr);
    }
    $par=file_get_contents($fpath);
    $par=json_decode($par,true);
    $dn = array();
    $config = array("private_key_bits"=>2048);
    $res_privkey = openssl_pkey_new($config);
    $res_csr = openssl_csr_new($dn, $res_privkey);
    $res_cert = openssl_csr_sign($res_csr, null, $res_privkey, 365);
    $str_cert="";
    openssl_x509_export($res_cert, $str_cert);
    $res_pubkey = openssl_pkey_get_public($str_cert);
    $prkey_data="";
    openssl_pkey_export ($res_privkey, $prkey_data);
    $pukey_data="";
    $keyData = openssl_pkey_get_details($res_pubkey);
    $pukey_data=$keyData['key'];
    
    
    $recript=0;
    if($par["cript"]==1){
        $lh=crc32($pukey);
        if($par["hesh"]!=$lh)return(1);
        else $recript=1;
    };
    $cell=new Cell();
    $it=new Item();
    $prk  = openssl_get_privatekey($prkey);
    $cell->Select();
    for($i=1;$i<=$cell->arr[0];$i++){
        $cell->GetItem($cell->arr[$i]);
        $it->ClearCell($cell);
        $val=$it->GetValue($cell->item_id);
        if($recript){
            $out="";
            openssl_private_decrypt(base64_decode($val), $out, $prk);
            $cell->value=$out;
        }else{
            $cell->value=$val;
        };
        $in=$cell->value;
        $in=substr($in,0,245);
        $out="";
        $it->id=$cell->item_id;
        if($in!==FALSE){
            openssl_public_encrypt ($in, $out,$res_pubkey);
            $it->value=base64_encode($out);
        }else{
            $it->value="";            
        }
        $it->Update();
    };
    $pukey_crc=crc32($pukey_data);
    $arr='{
    "cript":1,
    "hesh":$pukey_crc
    }';
    $pathpr=$PathLoc."/cls/private.cls";
    $pathpu=$PathLoc."/cls/public.cls";
    file_put_contents($fpath,$arr);
    file_put_contents($pathpr,$prkey_data);
    file_put_contents($pathpu,$pukey_data);
}
}
?>
