<?php
    $nuser=new ShellUser();
    $caps="Добавление нового пользователя";
    if(isset($_GET['item'])){
        $nuser->GetItem($_GET['item']);
        $caps="Просмотр пользователя ".$nuser->login;
    }
?>
<div class="sd_hd"><?php echo $caps;?></div>
<form autocomplete="off" data-id="<?php echo $nuser->id;?>">
<div class="frm_str"><label for="usr_name">Логин</label><input id="usr_name" autocomplete="off" type="text" placeholder="логин" required value="<?php echo $nuser->login;?>" <?php  if($nuser->id) echo " readonly";?>></div>
<div class="frm_str"><label for="usr_jab">Jabber</label><input id="usr_jab" autocomplete="off" type="email" placeholder="имя@jabber.ru" required value="<?php echo $nuser->jabber;?>"></div>
<div class="frm_str"><label for="usr_api">API key</label><input id="usr_api" autocomplete="off" type="text" value="<?php echo $nuser->apikey;?>"></div>
<div class="frm_str"><label for="usr_role">Тип пользователя</label>
<select id="usr_role" size=1>
  <option <?php if($nuser->role==9)echo selected;?> value="9">Пользователь</option>
  <option <?php if($nuser->role==1)echo selected;?> value="1">Администратр</option>
  <option <?php if($nuser->role==0)echo selected;?> value="0">Заморожен</option>
</select></div>
<?php
if($nuser->id)echo "<div class='frm_str'><input type='checkbox' id='usr_ispass' value='1'><label for='usr_ispass' style='margin-top: 15px;'>Изменить пароль</label></div>";
?>
<div class="frm_str"><label for="usr_pass">Пароль</label><input id="usr_pass" autocomplete="off" type="password" value=""></div>
<div class="frm_str"><label for="usr_pass1">Подтверждение</label><input autocomplete="off" id="usr_pass1" type="password" value=""></div>
<div class="frm_str"><div class='button'>Сохранить</div></div>
<div class="frm_str"><span id="usr_resume"></span></div>
</form>
<div class="sd_ft"></div>