<?php
$do=$_POST["do"];
if($do=="set"){
    $arr=array();
    foreach($_FILES as $key=>$val){
        if(!$val["error"]){
            $arr[$val['name']]=file_get_contents($val['tmp_name']);
        };
    };
    echo json_encode($arr);
    exit;
}
if($do=="zp"){
    $arr=array();
    $tmp=$PathLoc."/cls/public.cls";
    if(file_exists($tmp))$arr["public_key"]=file_get_contents($tmp);
    $tmp=$PathLoc."/cls/private.cls";
    if(file_exists($tmp))$arr["private_key"]=file_get_contents($tmp);
    echo json_encode($arr);
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
}
.titl{
width:150px;    
}
.ef_btn{
margin:25px 15px;
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
        kvo=0;
        if($("#ef_publ").prop('files').length){
            kvo++;
            f1=$("#ef_publ").prop('files')[0];
        };
        if($("#ef_priv").prop('files').length){
            kvo++;
            f2=$("#ef_priv").prop('files')[0];
        };
        if(kvo!=2){alert("Не заполнены все поля!");return;};
        console.log(document.forms.pgp_frm);
        var formData=new FormData();
        formData.append("tpl","frm_pgp");
        formData.append("do","set");
        formData.append("publ",f1,"public_key");
        formData.append("priv",f2,"private_key");
        console.log(formData.getAll("tpl"));
        $.ajax({
            type: "POST",
            url: "command.php",
            data: formData,
            processData:false,
            contentType: false,
            cache: false,
            async: true,
            
            success: function(qstr){
               if(qstr!="0"){
                   ls = localStorage;
                   jsn=JSON.parse(qstr);
                   ls.setItem("public_key",jsn.public_key);
                   ls.setItem("private_key",jsn.private_key);
                   alert("Ключи сохранены!");
                   location.reload();
               }else alert("Ошибка выполнения!");
            }
        })
    };
    if(ret=="zp"){
        param={
            "tpl":"frm_pgp",
            "do":"zp"
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            
            success: function(qstr){
               if(qstr!="0"){
                   ls = localStorage;
                   jsn=JSON.parse(qstr);
                   ls.setItem("public_key",jsn.public_key);
                   ls.setItem("private_key",jsn.private_key);
                   alert("Ключи сохранены!");
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
<div class="ef_caps str">Установка ключей</div>
<div class="ef_line str">
    <div class="titl">Public KEY:</div>
    <input id='ef_publ' type="file">
</div>
<div class="ef_line str">
    <div class="titl">Private KEY:</div>
    <input id='ef_priv' type="file">
</div>
<div class="ef_line str">
    <div class="ef_btn" data-id="ok">ОК</div>
    <div class="ef_btn" data-id="er">Отмена</div>
    <div class="ef_btn" data-id="zp">Запрос</div>
</div>
</form>
</div>

<?php
}
?>
