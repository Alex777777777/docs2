$(document).ready(function(){
    $("div.bd_item").mouseenter(function(){
        $(this).css("background","#fff");
        ob=$(this)[0];
        ltop=ob.offsetTop;
        lleft=ob.offsetLeft;
        lwd=ob.offsetWidth;
        lht=ob.offsetHeight;
        $(this).children(".it_desc").children(".it_btn").css({
            "top":ltop+lht-30,
            "left":lleft+lwd-30,
            "display":"block"
            
        })
    }).mouseleave(function(){
        $(this).css("background","#ddd");
        $(this).children(".it_desc").children(".it_btn").css("display","none");
    })
    $(".it_btn").mousedown(function(){
        $(this).css({"background":"#fff","color":"#000"});}).mouseup(function(){
        $(this).css({"background":"#000","color":"#fff"});
    })
    $(".it_bt_e").click(function(){
        lid=$(this).parent().parent().parent().attr("data-id");
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=doc&item="+lid;
    })
    $(".it_bt_x").click(function(){
        lid=$(this).parent().parent().parent().attr("data-id");
        if(!confirm("Действительно удалить таблицу?"))return;
        param={
            "tpl":"cmd_docs",
            "do":"del",
            "id":lid
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr=="1"){
                    document.location.reload()
                }else alert("Ошибка удаления тыблицы!");                 
            }
        })
    })
    $("div.it_desc.itn").click(function(){
        param={
            "tpl":"cmd_docs",
            "do":"new"
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr=="1") window.location.reload();
                else alert("Ошибка добавления тыблицы!");                
            }
        })
    })
    $(".hdp_caps").html(DocName);
})