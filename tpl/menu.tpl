<div class='wrap'>
<div class="mmenu">
<h3>Меню</h3>

<?php
if($user->role==1){
?>
<div class='musers smenu'>
<h4>Безопасность</h4>
<div class='mitem' data-item="newuser">Новый пользователь</div>
<div class='mitem' data-item="users">Пользователи</div>
</div>
<?php
};  
?>
<div class='msrcs smenu'>
<h4>Документы</h4>
<div class='mitem' data-item="newdoc">Новый документ</div>
<div class='mitem' data-item="docs">Мои документы</div>
<div class='mitem' data-item="docsa">Общие документы</div>
</div>
<div class='mresum smenu'>
<h4>Истрия</h4>
<div class='mitem' data-item="history">Мои документы</div>
<div class='mitem' data-item="historya">Общие документы</div>
</div>
</div>
<div class='side'>
<?php
require($do);
?>
</div>
</div>

