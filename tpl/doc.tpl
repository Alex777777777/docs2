<?php
require($PathLoc."/cls/docs.cls");
require($PathLoc."/cls/item.cls");
$lid=$_GET["item"];
$doc=new Docs();
$doc->GetItem($lid);
$cell=new Cell();
?>
<script>
DocRowsCount=<?= $doc->rows;?>;
DocColsCount=<?= $doc->cols;?>;
</script>
<div class="sd_hd">
<div class="hdl"><div>Имя:<input id="tb_name" type="text" value='<?= $doc->name;?>'></div>
<div>Описание:<input id="tb_descr" type="text" value='<?= $doc->descr;?>'></div>
</div>
<div class="hdr">
<div>Строк:<input id="tb_rows" type="text" value='<?= $doc->rows;?>'></div>
<div>Колонок:<input id="tb_cols" type="text" value='<?= $doc->cols;?>'></div>
<div class="hd_btn">Записать</div>
</div>
</div>

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
    $cell->doc_id=$doc-id;
    $cell->col=$ii;
    $cell->row=$i;
    $cell->GetCell();
    $cell->GetValue();
    if($ii==0){
?>
    <div class="col col<?= $ii;?>" data-id="{<?= "'row':".$i.",'col':".$ii?>}"><div><?php if($i)echo $i;?></div></div>
<?php        
    }else{
?>
    <div class="col col<?= $ii;?>" data-id="{<?= "'row':".$i.",'col':".$ii?>}"><div><?= $cell->value;?></div></div>
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