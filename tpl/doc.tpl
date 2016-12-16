<?php
require($PathLoc."/cls/docs.cls");
require($PathLoc."/cls/item.cls");
$lid=$_GET["item"];
$doc=new Docs();
$doc->GetItem($lid);
$cell=new Cell();
?>
<div class="sd_hd"><?php echo $doc->name;?></div>
<div class="sd_bd">
<?php

?>
<div class="doc" data-id='<?= $doc->id;?>'>
<?php 
for($i=0;$i <= $doc->rows;$i++){
?>
<div class="row row<?= $i;?>">
<?php
for($ii=0;$ii <= $doc->cols;$ii++){
    $cell->GetCell($doc->id,$i,$ii);
    if($ii==0){
?>
    <div class="col col<?= $ii;?>" data-id="{<?= $i.",".$ii?>}"><div><?php if($i)echo $i;?></div></div>
<?php        
    }else{
?>
    <div class="col col<?= $ii;?>" data-id="{<?= $i.",".$ii?>}"><div><?= $cell->value;?></div></div>
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