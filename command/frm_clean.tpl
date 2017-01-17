<?php
$do=$_POST["do"];
if($do=="set"){
    $tm1=$PathLoc."/cls/cript.ini";
    if(!file_exists($tm1)){echo "0";exit;}
    $cr_data=file_get_contents($tm1);
    $cr=json_decode($cr_data,true);
    $tdata=$_POST['pukey'];
    if(crc32($tdata)!=$cr["hesh"]){echo "0";exit;}
    $tmp=$PathLoc."/cls/public.cls";
    if(file_exists($tmp))unlink($tmp);
    if($tdata)file_put_contents($tmp,$tdata);
    $tmp=$PathLoc."/cls/private.cls";
    if(file_exists($tmp))unlink($tmp);
    $tdata=$_POST['prkey'];
    if($tdata)file_put_contents($tmp,$tdata);
    echo "1";
    exit;
}
if($do=="del"){
    $tmp=$PathLoc."/cls/public.cls";
    if(file_exists($tmp))unlink($tmp);
    $tmp=$PathLoc."/cls/private.cls";
    if(file_exists($tmp))unlink($tmp);
    echo "1";
    exit;
}
if($do=="get"){    
?>
<style>
#ext_frm{
height: 210px;
width: 400px;
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
margin:10px 5px;
height: 50px;
}
.titl{
width:150px;    
}
.stre>.ef_btn{
    margin:20px auto;
}
div.stre>.ef_btn{
    float:none;
}
.ef_btn{
margin:10px 15px;
background:#999;
color:#fff;
border-radius:6px;
box-shadow: 2px 2px 5px #000;
width: 160px;
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
    if(ret=="del"){
        param={
            "tpl":"frm_clean",
            "do":"del"
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            
            success: function(qstr){
               if(qstr!="0"){
                   alert("Ключи удалены!");
               }else alert("Ошибка удаления!");
            }
        });
    }
    if(ret=="set"){
        param={
            "tpl":"frm_clean",
            "do":"set",
            "pukey":localStorage.public_key,
            "prkey":localStorage.private_key
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            
            success: function(qstr){
               if(qstr!="0"){
                   alert("Ключи восстановлены!");
               }else alert("Ошибка выполнения!");
            }
        });
    }
    obj=$("#ext-wrp");
    obj.css("display","none");
    obj.html("");
});
});
</script>
<div id='ext_frm'>
<form name="pgp_frm" method="post" enctype="multipart/form-data">
<div class="ef_caps str">Очистка ключей</div>
<div class="ef_line str">
    <div class="ef_btn" data-id="del">Удалить ключи</div>
    <div class="ef_btn" data-id="set">Восстановить ключи</div>
</div>
<div class="ef_line stre">
    <div class="ef_btn" data-id="chencel">Отмена</div>
</div>
</form>
</div>

<?php
}
?>
