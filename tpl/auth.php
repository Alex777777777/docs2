<?php
$resume="";
if(isset($_POST["login"])){
    $login=$_POST["login"];
    $pass="";
    $pass=@$_POST["pass"];
    $user=new ShellUser();
    $user->authing=1;
    $user->Open($login,$pass);
    if($user->valid){
        if($user->role){
        $_SESSION["user"]=$login;
        $_SESSION["pass"]="".crc32(md5($pass));
        header("Location: http://".$_SERVER['HTTP_HOST'].$_SERVER['SCRIPT_NAME']);
        exit;
        };
        $resume="Пользователь заблокирован, обратитесь к администратору!";
    }else $resume="Неверный логин или пароль!";
    
}
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Вход</title>
<style>
#fauth{
    display: block;
    border: 1px solid;
    width: 270px;
    margin: auto;
}
.fauth_str{
    display:flex;
    margin:5px;
}
.fauth_str>span{
    display:block;
    width: 100px;
}
.fauth_str1>input{
    display: block;
    margin: auto;
}
.resume{
    color:red;
    text-align: center;
    font-size: 16pt;
}
</style>
</head>
<body>
<form id="fauth" action="index.php?do=auth" method="POST" enctype='multipart/form-data' >
<div class="fauth_str"><span>Логин</span><input type=text name='login'></div>
<div class="fauth_str"><span>Пароль</span><input type=password name='pass'></div>
<div class="fauth_str1"><input type=submit value='Отправить'></div>
</form>
<div class="resume"><?php echo $resume;?></div>
</body>
</html>