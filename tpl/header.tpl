<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Lang" content="ru">
<title>ShellSrv</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/menu.css">
<script src="js/jquery.js"></script>
<script src="js/script.js"></script>
<?php
    switch ($do){
        case "newuser.tpl":
            echo "<link rel='stylesheet' type='text/css' href='css/newuser.css'>\n";
            echo "<script src='js/newuser.js' type='text/javascript'></script>\n";
        break;
        case "users.tpl":
            echo "<link rel='stylesheet' type='text/css' href='css/users.css'>\n";
            echo "<script src='js/users.js' type='text/javascript'></script>\n";
        break;
        case "docs.tpl":
        case "docsa.tpl":
        case "docsb.tpl":
            echo "<link rel='stylesheet' type='text/css' href='css/docs.css'>\n";
            echo "<script src='js/docs.js' type='text/javascript'></script>\n";
        break;
        case "doc.tpl":
            echo "<link rel='stylesheet' type='text/css' href='css/doc.css'>\n";
            echo "<script src='js/doc.js' type='text/javascript'></script>\n";
        break;
        case "newdoc.tpl":
            echo "<link rel='stylesheet' type='text/css' href='css/newdoc.css'>\n";
            echo "<script src='js/newdoc.js' type='text/javascript'></script>\n";
        break;
    }

?>
</head>
<body>
<div id="ext-wrp"></div>
<div class="hd_panel">
<div class='btn' data-id="back">&ll;&ll; Back</div>
<div class='btn' data-id="logout">Logout</div>
</div>