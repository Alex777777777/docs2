$(document).ready(function(){
    var str = $('#params').attr('data-id');
    var o = JSON.parse(str);
    $('.row').width(10000);
    console.log($('.row').width());
        for (var key in o) {
                
            //$('.col'+key+', .head'+key).width(o[key]);
            
            //console.log( "Ключ: " + key + " значение: " + o[key] );
            //console.log(d);
        }
    

});