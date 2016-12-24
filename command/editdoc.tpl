<?php
$ldo=$_POST["do"];
switch($ldo){
    case "set":
        require("cls/item.cls");
        require("cls/access.cls");
        $acs=new Access();
        $obj=new Cell();
        $lid=json_decode($_POST["id"] ,true);
        $obj->doc_id=$_POST["doc"];
        $obj->row=$lid["row"];
        $obj->col=$lid["col"];
        $obj->GetCell();
        $obj->value=$_POST["val"];
        $obj->Save();
        $acs->GetCell($obj);
        $acs->UnLock();
    break;
    case "name":
        require("cls/docs.cls");
        $obj=new Docs();
        $obj->id=1;
        $obj->name=$_POST["name"];
        $obj->descr=$_POST["descr"];
        $obj->cols=0+$_POST["cols"];
        $obj->rows=0+$_POST["rows"];
        $obj->Save();
    break;
    case "access":
        require("cls/access.cls");
        $acs=new Access();
        $acs->doc=$_POST["doc"];
        $lid=json_decode($_POST["id"] ,true);
        $acs->row=$lid["row"];
        $acs->col=$lid["col"];
        $acs->Get();
        if($acs->flag){
            $lusr=new ShellUser();
            $lusr->GetItem($acs->user);
            echo '{"lock":"lock","user":"'.$lusr->login.'","date":"'.$acs->date.'"}';
        }else {
            echo '{"lock":"unlock"}';
            $acs->Lock();
        };
        exit;
    break;
    case "unlock":
        require("cls/access.cls");
        $acs=new Access();
        $acs->doc=$_POST["doc"];
        $lid=json_decode($_POST["id"] ,true);
        $acs->row=$lid["row"];
        $acs->col=$lid["col"];
        $acs->Get();
        if($acs->flag){
            if($acs->user==$user->id){
                $acs->UnLock();
            };
        };
        exit;
    break;
}

if($obj->LastErr)echo "0";
else echo "1";
?>
