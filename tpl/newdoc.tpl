<?php
require($PathLoc."/cls/vch_prj.cls");
$nprj=new vchPrj();
    $caps="Новый шаблон";
    if(isset($_GET['item'])){
        $nprj->GetItem($_GET['item']);
        $caps="Изменение шаблона";
    }
?>
<div class="sd_hd"><?php echo $caps;?></div>
<div class="sd_bd prj_prop">
 <div class="proj_name0">
    <div id="user_id" data-uid="<?php echo $user->id;?>" data-id="<?php echo $nprj->id;?>" style="display:none"></div>
    <div class="f_str proj_name"><div class="f_caps">Наименование:</div><input class="f_name" value="<?php echo $nprj->name;?>"></div>
    <div class="f_str proj_descr"><div class="f_caps">Описание:</div><textarea class="f_descr"><?php echo $nprj->descr;?></textarea></div>
 </div>
 <div class="proj_namer">
    <div class="f_str f_fl"><input type="checkbox" <?php if($nprj->user_id==0)echo "checked"; ?>>Общий шаблон</div>
    <div id="f_btn_del" class="f_btn">Удалить</div>
    <div id="f_btn_save" class="f_btn">Записать</div>
 </div>
</div>
<div class="sd_bd prg_list">
<div class="sd_menu"><div class="sd_menu_it" data-num="0">Домены</div><div class="sd_menu_it" data-num="1">IP - адреса</div><div class="sd_menu_it" data-num="2">Файлы</div></div>
<div class="sd_list"></div>
</div>
<div class="sd_ft"></div>