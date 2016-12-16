var curl=0;
function SetListener(){
    $("li.li_item").click(function(){
        lid=$(this).attr("data-id");
        ltpl="";
        switch (curl){
            case 0:
                ltpl="getdmstr";
            break;
            case 1:
                ltpl="getipstr";
            break;
            case 2:
                ltpl="getfilestr";
            break;
        }
        param={
            "tpl":ltpl,
            "id":lid,
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr!="0"){
                    arr=qstr.split("~;~")
                    $(".lt_str>.lt_domain").attr("data-id",arr[0]).val(arr[1]);
                    $(".lt_str>.lt_domain").parent().css("display","block");
                    $(".lt_str>.lt_file").parent().css("display","none");
                    $(".lt_str>textarea").val(arr[2].trim());
                    lstr="домен";
                    if(curl==1)lstr="ip-адрес";
                    if(curl==2)lstr="файл";
                    $(".lt_str>.lt_hd").html("Изменить "+lstr);
                };
            }
        })
    })
    $("div.btn.bt_s").click(function(){
        lid=(+($(".lt_str>input").attr("data-id")));
        lname=$(".lt_str>input").val();
        ldescr=$(".lt_str>textarea").val();
        lproj_id=(+($("#user_id").attr("data-id")));
        ltpl="";
        switch (curl){
            case 0:
                ltpl="adddomain";
            break;
            case 1:
                ltpl="addip";
            break;
            case 2:
                if(!lid){
                    AddFile();
                    return;
                }
                ltpl="addfile";
            break;
        }
        param={
            "tpl":ltpl,
            "id":lid,
            "name":lname,
            "descr":ldescr,
            "proj_id":lproj_id
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                GetList(curl)
            }
        })
        
    })
    $("div.btn.bt_n").click(function(){
        $(".lt_str>input").val("");
        $(".lt_str>input").attr("data-id","0");
        $(".lt_str>textarea").val("");
        lstr="домен";
        if(curl==1)lstr="ip-адрес";
        if(curl==2)lstr="файл";
        $(".lt_str>.lt_hd").html("Добавить "+lstr);
        if(curl==2){
            $(".lt_str>.lt_domain").attr("data-id","0").val("");
            $(".lt_str>.lt_domain").parent().css("display","none");
            $(".lt_str>.lt_file").parent().css("display","block");
            $(".lt_str>textarea").val("");
        }
    })
    $("div.btn.bt_x").click(function(){
        lid=(+($(".lt_str>input").attr("data-id")));
        if(!lid){alert("Не выбран элемент!");return;};
        ltpl="";
        switch (curl){
            case 0:
                ltpl="deldomain";
            break;
            case 1:
                ltpl="delip";
            break;
            case 2:
                ltpl="delfile";
            break;
        }
        param={
            "tpl":ltpl,
            "id":lid
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                GetList(curl)
            }
        })
        
    })
    function AddFile(){
        fData= new FormData();
        ls=$(".lt_file");
        if(!ls[0].files.length){alert("Не выбран файл!");return;}
        fData.set('lfile', ls[0].files[0], ls.val());
        fData.set('tpl','addfile');
        fData.set('id','0');
        fData.set('descr',$(".lt_str>textarea").val());
        pid= (+($("#user_id").attr("data-id")));
        fData.set('proj_id',pid);
        $.ajax({
            url: 'command.php',
            type: 'POST',
            contentType: false,
            processData: false,
            dataType: 'json',
            data: fData,
            beforeSend: function(loading) { 
                Resize1();
            },
            success: function(data){
                $('.lt_shtor').css("display", "none");
                GetList(curl);
            }
        })
    }
}
function GetList(nl){
    tpl="";
    switch(nl){
        case(0):
           tpl="getdomen";
        break;
        case(1):
            tpl="getips";
        break;
        case(2):
            tpl="getfiles";
        break;
    }
    lid=(+($("#user_id").attr("data-id")));
    param={
        "tpl":tpl,
        "id":lid,
    };
    $.ajax({
        type: "POST",
        url: "command.php",
        data: param,
        cache: false,
        async: true,
        success: function(qstr){
            $(".sd_list").html(qstr);
            SetListener();
            if($("#user_id").attr("data-id")=="0"){
                $(".lt_shtor").css({
                    "display":"block"
                })
                Resize1();
                $(".lt_shtor>div").html("Сохраните шаблон");
            }
        }
    })
}
$(document).ready(function(){
    $(".sd_menu_it").click(function(){
        if($("#user_id").attr("data-id")=="0"){
            return;
        };
        numl=(+$(this).attr("data-num"));
        $(".sd_menu_it")[curl].style.background="";
        $(".sd_menu_it")[numl].style.background="rgb(240,240,0)";
        curl=numl;
        GetList(curl);
    })
    $("#f_btn_save").click(function(){
        lname=$(".f_name").val();
        ldescr=$(".f_descr").val();
        lui=(+($("#user_id").attr("data-uid")));
        lid=(+($("#user_id").attr("data-id")));
        if($("div.f_fl>input").prop("checked"))lui=0;
        param={
            "tpl":"addproj",
            "id":lid,
            "name":lname,
            "descr":ldescr,
            "user_id":lui
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr=="1"){
                    lc=document.location;
                    document.location=lc.origin+lc.pathname+"?do=projects";
                }                 
            }
        })
    })
    $("#f_btn_del").click(function(){
        lid=(+($("#user_id").attr("data-id")));
        param={
            "tpl":"delproj",
            "id":lid,
        };
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr=="1"){
                    lc=document.location;
                    document.location=lc.origin+lc.pathname+"?do=projects";
                }                 
            }
        })
    })
    $(".sd_menu_it")[curl].style.background="rgb(240,240,0)";
    GetList(curl);
})
function Resize1(){
    lobj=$('.lt_shtor');
    ltop=$(".sd_list").css("top");
    lleft=$(".sd_list").css("left");
    lwd=$(".sd_list").css("width");
    lht=$(".sd_list").css("height");
    lobj.css({
        "display":"block",
        "top":ltop,
        "left":lleft,
        "width":lwd,
        "height":lht
    });
}