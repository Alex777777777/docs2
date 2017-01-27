// ==UserScript==
// @name        SITableCrypt
// @namespace   SITable
// @description Криптовая система таблицы
// @include     http://shell.loc/docs2/*
// @require     http://shell.loc/docs2/js/jquery.js
// @version     1
// @grant       none
// ==/UserScript==
try{
if(typeof DocName !== "undefined"){    
$(document).on('click', '.ef_btn', function(){
    ret=$(this).attr("data-id");
    if(ret=="ok"){
        pubk=$("#ef_publ").val();
        prvk=$("#ef_priv").val();
        ls=unsafeWindow.localStorage;
        ls.setItem("public_key",pubk);
        ls.setItem("private_key",prvk);
    };
    if(ret=="zp"){
        ls=unsafeWindow.localStorage;
        pubk=ls.getItem("public_key");
        prvk=ls.getItem("private_key");
        $("#ef_publ").val(pubk.trim());
        $("#ef_priv").val(prvk.trim());
        return;
    };
    obj=$("#ext-wrp");
    obj.css("display","none");
    obj.html("");
});
$(document).on('click', '#btn_recript', function(){
    if(!confirm("Перекодировать таблицы?"))return;
    ls=unsafeWindow.localStorage;
    pubk=ls.getItem("public_key");
    prvk=ls.getItem("private_key");
    param={
    "tpl":"recript",
    "pukey":pubk,
    "prkey":prvk
    }
    $.ajax({
        type: "POST",
        url: "command.php",
        data: param,
        cache: false,
        async: true,
        success: function(qstr){
            if((qstr==="0")){
                alert("Ошибка выполнения!");
                return;
            };
            if((!qstr)){
                alert("Внутренняя ошибка выполнения!");
                return;
            };
            if(qstr=="7"){
                alert("Ошибка!\nНеверные ключи для преобразования!");
                return;
            };
            if(qstr=="8"){
                alert("Ошибка!\nНеверные ключи для преобразования!");
                return;
            };
            if(qstr=="9"){
                alert("Ошибка!\nНедостаточно прав.");
                return;
            };
            obj=$("#ext-wrp");
            obj.html("");
            obj.css("display","none");
            arr=jQuery.parseJSON(qstr,true);
            console.log(arr);
            if(arr){
                ls=unsafeWindow.localStorage;
                ls.setItem("public_key",arr.puk);
                ls.setItem("private_key",arr.prk);
                alert("Таблицы перекодированы!");
            }
            unsafeWindow.location.reload();            
        }
    })
});
unsafeWindow.cript = new JSEncrypt();
ls=unsafeWindow.localStorage;
unsafeWindow.cript.setPrivateKey(ls.private_key);
if(unsafeWindow.DocIsCript){
    ReCriptDoc();
}
}
} catch(e){console.error(e)}