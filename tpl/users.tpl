<div class="sd_hd">Пользователи системы</div>
<div class="sd_bd">
<?php
$suser=new ShellUser();
$suser->Select();
for($i=1;$i<=$suser->arr[0];$i++){
    $suser->GetItem($suser->arr[$i]);
?>
<div class="bd_item" data-id='<?php echo $suser->id;?>'>
<div class='it_str'><span class="it_caps">Логин:</span><div class="it_login it_it"><?php echo $suser->login;?></div>
<span class="it_caps">Тип доступа:</span><div class="it_role it_it"><?php echo $suser->GetRole();?></div></div>
<div class='it_str'><span class="it_caps">Акаунт Jabber:</span><div class="it_jabb it_it"><?php echo $suser->jabber;?></div></div>
<div class='it_str'><span class="it_caps">API key:</span><div class="it_api it_it"><?php echo $suser->apikey;?></div></div>
<div class='it_str'><div class="it_btn it_edit">Правка</div><div class="it_btn it_froz">Заморозить</div><div class="it_btn it_del">Удалить</div></div>
</div>
    
<?php
        
}
?>
</div>
<div class="sd_ft"></div>