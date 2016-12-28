<?php
require($PathLoc."/cls/docs.cls");
require($PathLoc."/cls/item.cls");
require($PathLoc."/cls/access.cls");
require($PathLoc."/cls/params.cls");
$acs=new Access();
$acs->ClearLock($user->id);
$itm=new Item();
$mitem=$itm->GetMaxItem();
$lid=$_GET["item"];
$doc=new Docs();
$doc->GetItem($lid);
$cell=new Cell();
$params = new Params();
$params->find(lid);
?>
<script>
DocRowsCount=<?= $doc->rows;?>;
DocColsCount=<?= $doc->cols;?>;
DocItCount=<?= $mitem;?>;
DocName='<?=$doc->name;?>';
</script>
<div class='wrap'>
<div class="sd_hd">
<img src="img/users.jpg"  title="Пользователи">
<img id="save_col" src="img/write.jpg" title="Записать">
<img src="img/setting.jpg" title="Настройка">
<div class="hd_descr"><div class="caps">Описание:</div><?= $doc->descr;?></div>
</div>
<div class="sd_bd">
<?php

?>
<div class="inphdb"><input id="inphd"></div>
<div class="doc" data-id='<?= $doc->id;?>'>
<div class="row row0">
       <?php 
for($i=0;$i <= $doc->cols;$i++){  
?>
  <div class="head head<?= $i;?>" data-id="<?=$i?>"><span class="sm">&laquo;</span><?php if($i)echo $i;?><span class="bg">&raquo;</span></div>
<?php
}
?>
</div>
<?php 
for($i=1;$i <= $doc->rows;$i++){
?>
<div class="row row<?= $i;?>">
<?php
for($ii=0;$ii <= $doc->cols;$ii++){
    $cell->doc_id=$doc->id;
    $cell->col=$ii;
    $cell->row=$i;
    $cell->GetCell();
    $cell->GetValue();
    if($ii==0){
?>
    <div class="col col<?= $ii;?>" data-id="{<?='*row*:'.$i.',*col*:'.$ii?>}"><div><?php if($i)echo $i;?></div></div>
<?php        
    }else{
?>
    <div class="col col<?= $ii;?>" data-id="{<?='*row*:'.$i.',*col*:'.$ii?>}"><div><?= $cell->value;?></div></div>
<?php
    }
}
?>
</div>
<?php    
}
?>
</div>
    
<?php
        
?>
</div>
<div class="sd_ft"></div>
<input id="inped" type="text" style="display:none; position:absolute;background: #f8f8c8;">
</div>