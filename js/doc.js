var LastCell;
var TimeOfUpdate=10000;
function MoveEdt(){
    if(LastCell){
        ll=LastCell[0].offsetLeft;
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
});
$(document).ready(function(){
    $(".col").click(function(){
        LastCell=$(this);
        txt=LastCell.children("div").html();
        ldoc=LastCell.parent().parent().attr("data-id");
        lid=LastCell.attr("data-id");
        edt=$("#inped");
        
        edt.css({"background":"#f8f8c8"});
        edt.attr("readonly",false);
        //pid=edt.attr("data-id");
        /*if(pid){
        param={
        "tpl":"editdoc",
        "do":"unlock",
        "doc":ldoc,
        "id":pid
        }
        $.ajax({
            type: "POST",
            url: "command.php",
            data: param,
            cache: false,
            async: true,
            success: function(qstr){                
            }
        })
        };*/
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
        edt.select();
    })
    $("#inped").keydown(function(e) {
        if(e.keyCode === 13) {
            lid=$(this).attr("data-id");
            $(this).removeAttr("data-id");
            lval=$(this).val();
            LastCell.children("div").html(lval);
            ldoc=LastCell.parent().parent().attr("data-id");
            $(this).css("display","none");
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
            })
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
    wh=DocColsCount*105+80;
    $(".row").css("width",wh+"px");
    GetUpdates();
})