<?php
require($PathLoc."/cls/docs.cls");
    $caps="Личные документы";
    $lid=$user->id;
    if($do=="docsa.tpl"){
        $caps="Общие документы";
        $lid=0;
    }
    
?>
<div class="sd_hd"><?php echo $caps;?></div>
<div class="sd_bd">
<?php
$doc=new Docs();
$doc->Select($lid);
for($i=1;$i<=$doc->arr[0];$i++){
    $doc->GetItem($doc->arr[$i]);
?>
<div class="bd_item" data-id='<?php echo $doc->id;?>'>
<div class='it_caps'><div class="it_bts"><div class="it_bt_e" title='Редактировать'>&equiv;</div><div class="it_bt_x" title='Удалить'>&KHcy;</div></div><?php echo $doc->name;?></div>
<div class='it_desc'><?php echo $doc->descr;?></div>
</div>
    
<?php
        
}
?>
</div>
<div class="sd_ft"></div>