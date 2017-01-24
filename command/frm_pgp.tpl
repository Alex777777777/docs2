<?php
$do=$_POST["do"];
if($do=="get"){    
?>
<style>
#ext_frm{
height: 435px;
width: 400px;
margin: 20px auto;
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
textarea{
width:390px;
height: 130px;
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
    obj=$("#ext-wrp");
    obj.css("display","none");
    obj.html("");
});
eval("Load_gpg();");
});
</script>
<div id='ext_frm'>
<form name="pgp_frm" method="post" enctype="multipart/form-data">
<div class="ef_caps str">Установка ключей</div>
<div class="ef_line str">
    <div class="titl">Public KEY:</div>
    <textarea id='ef_publ'></textarea>
</div>
<div class="ef_line str">
    <div class="titl">Private KEY:</div>
    <textarea id='ef_priv'></textarea>
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
