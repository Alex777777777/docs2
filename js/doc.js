var LastCell;
var TimeOfUpdate=10000;
var colsParam = {
    "tpl":"column",
    "do":"colup",
    "val":{},
};
function SetValueEdt(obj){
    lid=obj.attr("data-id");
    obj.removeAttr("data-id");
    lval=obj.val();
    LastCell.children("div").html(lval);
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

function MoveEdt(){
    if(LastCell){
        sc=$(".doc")[0].scrollLeft;
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
        if(ll<200)edt.css("display","none");
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
                    $(lkey).children("div").html(arr.val);
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
    wd=$(window)[0].innerWidth;
    $(".doc").css("width",wd-250);
    $(".inphdb").css("min-width",wd-250);
    
    
});
$(document).ready(function(){
    $(".col").click(function(){
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
        LastCell=$(this);
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
    })
    $("#inped").keydown(function(e) {
        if(e.keyCode === 13) {
            SetValueEdt($(this));
        }
    })
    $(".hd_btn").click(function(){
        lname=$("#tb_name").val();
        ldescr=$("#tb_descr").val();
        lrows=$("#tb_rows").val();
        lcols=$("#tb_cols").val();
        param={
            "tpl":"editdoc",
            "do":"name",
            "name":lname,
            "descr":ldescr,
            "rows":lrows,
            "cols":lcols,
            }
            $.ajax({
                type: "POST",
                url: "command.php",
                data: param,
                cache: false,
                async: true,
                success: function(qstr){
                    if(qstr=="0"){
                        alarm("Ошибка!");
                    }else location.reload();           
                }
            })
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
    });
    $( ".doc" ).scroll(function() {
        MoveEdt();
    });
    
    
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
    });
    
    wh=DocColsCount*102+43;
    $(".row").css("width",wh+"px");
    GetUpdates();
})