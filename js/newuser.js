$(document).ready(function(){
    $(".btn[data-id='back']").click(function(){
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=users";
    })
    $(".button").click(function(){
        $("#usr_resume").html("Отправка запроса");
        $("#usr_resume").css("color","green");
        $("#usr_pass1").css("border","1px solid #aaa");
        $("#usr_pass").css("border","1px solid #aaa");
        $("#usr_name").css("border","1px solid #aaa");
        lname=$("#usr_name").val();
        lpass=$("#usr_pass").val();
        lpass1=$("#usr_pass1").val();
        lrole=$("#usr_role").val();
        lid=$("form").attr("data-id");
        lispass=true;
        if(lid!="0")lispass=$("#usr_ispass").prop("checked");
        if(lispass){
            if(lpass!=lpass1){
                $("#usr_resume").html("Пароли не совпадают.");
                $("#usr_resume").css("color","#f00");
                $("#usr_pass1").css("border","1px solid #f00");
                return;
            }
            if(lpass==""){
                $("#usr_resume").html("Пароль пустой.");
                $("#usr_resume").css("color","#f00");
                $("#usr_pass").css("border","1px solid #f00");
                return;
            }
        }
        if(lname==""){
                $("#usr_resume").html("Пустой логин");
                $("#usr_resume").css("color","#f00");
                $("#usr_pass").css("border","1px solid #f00");
                return;
        }
        param={
            "tpl":"adduser",
            "id":lid,
            "name":lname,
            "pass":lpass,
            "pass1":lpass1,
            "role":lrole,
            "ispass":lispass
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                ret=+qstr;
                if(!ret){
                    lc=document.location;
                    document.location=lc.origin+lc.pathname+"?do=users";
                }else{
                    $("#usr_resume").html("Ошибка! "+qstr);
                    $("#usr_resume").css("color","#f00");
                }            
            }
        })
    })
})