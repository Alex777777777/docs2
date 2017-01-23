$(document).ready(function(){
    var str = $('#params').attr('data-id');
    var o = JSON.parse(str);
        for (var key in o) {
            if($('.col'+key).width() < o[key]){
                var res = o[key]-$('.col'+key).width();
               $('.row').width($('.row').width()+res); 
            }
            $('.col'+key+', .head'+key).width(o[key]);
        }
});