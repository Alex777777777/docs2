var LastCell;
$(window).ready(function(){
    $(".col").click(function(){
        LastCell=$(this);
        txt=$(this).children("div").html();
        ll=$(this)[0].offsetLeft;
        lt=$(this)[0].offsetTop;
        lw=$(this)[0].clientWidth-4;
        lh=$(this)[0].clientHeight-4;
        edt=$("#inped");
        edt.css({
            "width":lw,
            "height":lh,
            "top":lt,
            "left":ll,
            "display":"block"
        });
        edt.val(txt);
        edt.select();
        edt.attr("data-id",$(this).attr("data-id"))
        
    })
    $("#inped").keydown(function(e) {
        if(e.keyCode === 13) {
            lid=$(this).attr("data-id");
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
})