<?php
require($PathLoc."/cls/docs.cls");
?>
<script>
DocName='Список документов';
</script>
<div class='wrap'>

<div class="sd_bd">
<?php
$doc=new Docs();
$doc->Select();
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
<div class="bd_item" data-id='0'>
<div class='it_caps itn'><?php echo "Новый документ";?></div>
<div class='it_desc itn'><div>Создать</div></div>
</div>
</div>
<div class="sd_ft"></div>
</div>