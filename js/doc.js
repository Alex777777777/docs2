var LastCell;
var TimeOfUpdate=10000;
var MoveFlag=0;
var colsParam = {
    "tpl":"column",
    "do":"colup",
    "doc":$(".doc").attr("data-id"),
    "val":{}
};
function ReCriptDoc(){
    if(DocIsCript==0)return;
    arr=$(".col>div");
    arr.each(function(i,elem){
        if($(elem).parent().hasClass("col0")==false){
            ldt=$(elem).html();
            if(ldt){
            ldt=cript.decrypt(ldt);
            $(elem).html(ldt);
            };
        };
    });
}
function SetValueEdt(obj){
    lid=obj.attr("data-id");
    obj.removeAttr("data-id");
    lval=obj.val();
    LastCell.children("div").html(lval);
    if( DocIsCript )lval=cript.encrypt(lval);
    ldoc=LastCell.parent().parent().attr("data-id");
    obj.css("display","none");
    param={
    "tpl":"editdoc",
    "do":"set",
    "val":lval,
    "doc":ldoc,
    "id":lid
    }
    $.ajax({
        type: "POST",
        url: "command.php",
        data: param,
        cache: false,
        async: true,
        success: function(qstr){
            if(qstr=="0"){
                LastCell.children().html("Ошибка!");
            };           
        }
    });
}
function MoveEdtTo(lpar,lkey){
    lstr=lpar.attr("data-id");
    lstr=lstr.split('*').join('"');
    pos=JSON.parse(lstr);
    switch(lkey){
        case 37:
            if(pos.col==1)return;
            lstr="{*row*:"+(pos.row)+",*col*:"+(pos.col-1)+"}";
        break;
        case 38:
            if(pos.row==1)return;
            lstr="{*row*:"+(pos.row-1)+",*col*:"+(pos.col)+"}";
        break;
        case 39:
            if(pos.col==DocColsCount)return;
            lstr="{*row*:"+(pos.row)+",*col*:"+(pos.col+1)+"}";
        break;
        case 40:
            if(pos.row==DocRowsCount)return;
            lstr="{*row*:"+(pos.row+1)+",*col*:"+pos.col+"}";
        break;        
    };
    pkey=".col[data-id='"+lstr+"']";
    MoveFlag=1;
    MoveTo($(pkey));
}
function MoveTo(mthis)
{   lid=mthis.attr("class");
    if(lid=="col col0")return;
    edt=$("#inped");
    if(LastCell){
        if(!edt.attr("readonly")){
            if(edt.css("display")=="block"){
                lval=LastCell.children("div").html().trim();
                rval=edt.val().trim();
                if(lval!=rval)SetValueEdt(edt);
                
            };
        };
    }
    LastCell=mthis;
    txt=LastCell.children("div").html();
    ldoc=LastCell.parent().parent().attr("data-id");
    lid=LastCell.attr("data-id");
    edt.css({"background":"#f8f8c8"});
    edt.attr("readonly",false);
    edt.attr("data-id",LastCell.attr("data-id"));
    param={
    "tpl":"editdoc",
    "do":"access",
    "doc":ldoc,
    "id":lid
    }
    $.ajax({
        type: "POST",
        url: "command.php",
        data: param,
        cache: false,
        async: true,
        success: function(qstr){
            ret=JSON.parse(qstr);
            edt=$("#inped");
            if(ret.lock=="lock"){
                edt.css({
                    "background":"red",
                });
                edt.attr("readonly",true);
                edt.attr("title","Заблокировано "+ret.user+" "+ret.date);
            }else{
                edt.css({
                    "background":"#f8f8c8"
                });
                edt.attr("readonly",false);
            }                
        }
    })
    MoveEdt();
    edt.val(txt);
    $("#inphd").val(txt);
    edt.select();
    
}
function MoveEdt(){
    if(LastCell){
        obj_doc=$(".doc")[0];
        sc=obj_doc.scrollLeft;
        ll=LastCell[0].offsetLeft-sc;
        lt=LastCell[0].offsetTop;
        lw=LastCell[0].clientWidth-4;
        lh=LastCell[0].clientHeight-4;
        edt=$("#inped");
        edt.css({
            "width":lw,
            "height":lh,
            "top":lt,
            "left":ll,
            "display":"block"
        });
        if(MoveFlag==1){
        wd=obj_doc.clientWidth;        
        if(ll<0){
            $(".doc").scrollLeft(sc+ll);
        };
        if(ll+lw>wd){
            $(".doc").scrollLeft(sc+ll+lw-wd);
        };
        MoveFlag=0;
        };
    };
}
function GetUpdates(){
    doc_id=$(".doc").attr("data-id");    
    param={
        "tpl":"updatedoc",
        "doc":doc_id,
        "id":DocItCount
    }
    $.ajax({
        type: "POST",
        url: "command.php",
        data: param,
        cache: false,
        async: true,
        success: function(qstr){
            ret=JSON.parse(qstr);
            if(!ret) return;
            if(ret.stat="OK"){
                ldt=ret.data;
                for(i=0;i<ldt.length;i++ ){
                    arr=ldt[i];
                    DocItCount=arr.id;
                    lkey=".col[data-id='{*row*:"+arr.row+",*col*:"+arr.col+"}']";
                    lval=arr.val;
                    if( DocIsCript )lval=cript.decrypt(lval);
                    $(lkey).children("div").html(lval);
                    ltxt="Изменил "+arr.user+" "+arr.date;
                    $(lkey).attr("title",ltxt);
                    $(lkey).css("background","#d1eaf6");
                    
                };
            }                
        }
    })    
setTimeout("GetUpdates()",TimeOfUpdate);
}
$(window).resize(function(){
    MoveEdt();
    wd=$("body")[0].clientWidth;
    wd=wd-10;
    $(".doc").css("width",wd);
    $("#inphd").css("width",wd-6);   
});
$(document).ready(function(){
    $(".col").click(function(){
        mthis=$(this);
        MoveTo(mthis);
    })
    $("#inped").keydown(function(e) {
        switch(e.keyCode){ 
            case 13: 
                SetValueEdt($(this));
            break;
            case 37:
            case 38:
            case 39:
            case 40:
                if(MoveEdtTo($(this),e.keyCode))SetValueEdt($(this));
                e.preventDefault();
            break;
        }
        
    })
    $("#inphd").keydown(function(e) {
        switch(e.keyCode){ 
            case 13:
                edt=$("#inped");
                if(edt.css("display")=="block"){SetValueEdt(edt);$(this).val("");};
            break;
        }
    })
    $("#inped").keypress(function(e) {
        setTimeout('$("#inphd").val($("#inped").val());',100);
    })
    $("#inphd").keypress(function(e){
        setTimeout('$("#inped").val($("#inphd").val());',100);
    })
    $('.head').hover(function(){
        $(this).find("span").css('display','block'); 
    },
    function(){
        $(this).find("span").css('display','none');
    });
    $('.head span.bg').click(function(){
       var sel = 'col'+$(this).parent().attr('data-id')+', .head'+$(this).parent().attr('data-id');
       $('.row').width($('.row').width()+10);
       $('.'+sel).width($(this).parent().width()+10);
       var column = $(this).parent().attr('data-id');
       colsParam.val[column] = $(this).parent().width();
       MoveEdt();
    });
    $('.head span.sm').click(function(){
       var sel = 'col'+$(this).parent().attr('data-id')+', .head'+$(this).parent().attr('data-id');
       lwd=$(this).parent().width();
       if((lwd-10)>24){
       $('.row').width($('.row').width()-10);
       $('.'+sel).width(lwd-10);
       var column = $(this).parent().attr('data-id');
       colsParam.val[column] = $(this).parent().width();
       MoveEdt();
       };
    })
    $( ".doc" ).scroll(function() {
        MoveEdt();
    })
    $(".btn").click(function(){
        lid=$(this).attr("data-id");
        if(lid=="back"){window.location ="?do=docs"}
    })
    $("#btn_setting").click(function(){
        lid=$(".doc").attr("data-id");
        param={
        "tpl":"frm_setting",
        "do":"get",
        "id": lid
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr!="0"){
                    obj=$("#ext-wrp");
                    obj.html(qstr);
                    obj.css("display","block");                    
                }else alert("Ошибка выполнения!");                            
            }
        })
    })
    $("#btn_pgp").click(function(){
        param={
        "tpl":"frm_pgp",
        "do":"get"
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){
                if(qstr!="0"){
                    obj=$("#ext-wrp");
                    obj.html(qstr);
                    obj.css("display","block");                    
                }else alert("Ошибка выполнения!"); 
            }
        })
    })
    $("#btn_addrow").click(function(){
        lid=$(".doc").attr("data-id");
        param={
        "tpl":"editdoc",
        "do":"addrow",
        "id": lid
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
    })
    $("#btn_addcol").click(function(){
        lid=$(".doc").attr("data-id");
        param={
        "tpl":"editdoc",
        "do":"addcol",
        "id": lid
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
    })
    $("#btn_users").click(function(){
        lc=document.location;
        document.location=lc.origin+lc.pathname+"?do=users";
    })
    $('#save_col').click(function(){
        
        $.ajax({
                type: "POST",
                url: "command.php",
                data: colsParam,
                cache: false,
                async: true,
                success: function(qstr){
                     colsParam.val = {};
                    console.log(qstr);           
                }
            });
    })
    wh=DocColsCount*102+43;
    $(".row").width(wh);
    //GetUpdates();
})