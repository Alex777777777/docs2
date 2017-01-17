$(document).ready(function(){
    $(".btn[data-id='back']").click(function(){
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=docs";
    })
    $("div.it_btn.it_edit").click(function(){
        lid=$(this).parent().parent().attr("data-id");
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=newuser&item="+lid;
    })
    $("#btn_newuser").click(function(){
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=newuser";
    })
    $("div.it_btn.it_froz").click(function(){
        lid=$(this).parent().parent().attr("data-id");
        lc=document.location;
        param={
            "tpl":"frozuser",
            "id":lid
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr="0"){
                    document.location.reload();
                }else alert("Ошибка!");           
            }
        })
    })   
    $("div.it_btn.it_del").click(function(){
        lid=$(this).parent().parent().attr("data-id");
        lc=document.location;
        param={
            "tpl":"deluser",
            "id":lid
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr="0"){
                    document.location.reload();
                }else alert("Ошибка!");           
            }
        })
    })
})