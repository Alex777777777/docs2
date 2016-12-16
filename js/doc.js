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
            LastCell.children("div").html($(this).val());
            $(this).css("display","none");
        }
    })
})