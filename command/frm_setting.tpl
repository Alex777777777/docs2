<?php
require("cls/docs.cls");
$do=$_POST["do"];
$lid=$_POST["id"];
$obj=new Docs();
$obj->GetItem($lid);
if($do=="set"){
    $obj->name=$_POST["name"];
    $obj->descr=$_POST["descr"];
    $obj->rows= $_POST["rows"];
    $obj->cols= $_POST["cols"];
    $obj->Save();
    if(!$obj->LastErr) echo "1";
    else echo "0";
    exit;
}
if($do=="get"){
    
?>

<style>
#ext_frm{
min-width: 300px;
min-height: 350px;
width: 300px;
margin: 150px auto;
background: #fff;
padding: 10px;
}
#ext_frm>.str{
margin:10px auto;   
}
.ef_caps{
text-align: center;
font-size: 20pt;
}
.ef_line{

}
#ef_descr{
width:290px;
height:100px;
}
.titl{
float:left;
width:150px;    
}
.ef_btn{
margin:10px 25px;
background:#999;
color:#fff;
border-radius:6px;
box-shadow: 2px 2px 5px #000;
width: 100px;
float: left;
text-align: center;
cursor: pointer;    
}
.ef_btn:hover{
box-shadow: 0 0 10px #000;
}
</style>
<script>
$(window).ready(function(){
$(".ef_btn").click(function(){
    ret=$(this).attr("data-id");
    if(ret=="ok"){
        lid=$("#ext_frm").attr("data-id");
        lname=$("#ef_name").val();
        ldescr=$("#ef_descr").val();
        lrows=$("#ef_rows").val();
        lcols=$("#ef_cols").val();
        param={
        "tpl":"frm_setting",
        "do":"set",
        "id": lid,
        "name":lname,
        "descr":ldescr,
        "rows":lrows,
        "cols":lcols
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr!="0"){
                    location.reload();                    
                }else alert("Ошибка выполнения!");                            
            }
        })
    };
    obj=$("#ext-wrp");
    obj.css("display","none");
    obj.html("");
});
});
</script>
<div id='ext_frm' data-id='<?=$obj->id;?>'>
<div class="ef_caps str">Установка параметров</div>
<div class="ef_line str">
    <div class="titl">Наименование:</div>
    <input id='ef_name' value="<?=$obj->name;?>">
</div>
<div class="ef_line str">
    <div class="titl" style="float:none;">Описание:</div>
    <textarea id='ef_descr'><?=$obj->descr;?></textarea>
</div>
<div class="ef_line str">
    <div class="titl">Кол-во строк:</div>
    <input id='ef_rows' value="<?=$obj->rows;?>">
</div>
<div class="ef_line str">
    <div class="titl">Кол-во колонок:</div>
    <input id='ef_cols' value="<?=$obj->cols;?>">
</div>
<div class="ef_line str">
    <div class="ef_btn" data-id="ok">ОК</div>
    <div class="ef_btn" data-id="er">Отмена</div>
</div>
</div>

<?php
}
?>
