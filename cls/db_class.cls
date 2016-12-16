<?php
class db_one{
	var $lHost;
	var $lnamedb;
	var $lUser;
	var $lPass;
	var $lCon;
	var $lqr;
	var $LastErr;
	function do_query($lQuery){
        $this->LastErr = FALSE;
		$this->lqr=mysqli_query($this->lCon,$lQuery);
        if($this->lqr==FALSE) $this->LastErr=FALSE;
        else $this->LastErr=TRUE;
	}
	function GetRow(){
        $this->LastErr=FALSE;
        if($this->lqr<>FALSE) {
		    $this->LastErr=TRUE;
            return(mysqli_fetch_array($this->lqr, MYSQL_ASSOC));
        } else {
            $this->LastErr=FALSE;
        };
	}

	function __construct(){
		$this->lHost="";
		$this->lnamedb="";
		$this->lUser="";
		$this->lPass="";
		$this->lCon="";
		$this->lqr="";
		$this->LastErr="";
		$lparam=file(__DIR__."/db_param.inc");
		$lkvo=count($lparam);
		foreach($lparam as $lstr){
			$pos=strpos($lstr, ":");
			if ($pos!=0){
				$lkey= strtolower(trim(substr($lstr,0,$pos)));
				$lval= trim(substr($lstr,$pos+1));
				switch ($lkey){
				case "host":
					$this->lHost=$lval;
					break;
				case "name db":
					$this->lnamedb=$lval;
					break;
				case "user":
					$this->lUser=$lval;
					break;
				case "pass":
					$this->lPass=$lval;
					break;
				};
			};

		};
	}
	function __destruct() {
    }
	function OpenDB(){
		$this->lCon= mysqli_connect($this->lHost, $this->lUser,$this->lPass);
		$this->LastErr=mysqli_select_db($this->lCon,$this->lnamedb);
	}
	function CloseDB(){
		mysqli_close($this->lCon);
	}
    function SqlScript($pfile){
        if(!file_exists($pfile))return -1;
        $lfile=file($pfile);
        $lstr=implode(" ", $lfile);
        $arr= array();
        $lstr=trim($lstr);
        while ($i=strpos($lstr,";")){
          $arr[]=substr($lstr,0,$i+1);
          $lstr=trim(substr($lstr,$i+1));
        };
        foreach($arr as $lstr){
        $ret=0;                   
        $this->do_query($lstr);
        if (!$this->LastErr)$ret++;
        };
        return($ret);
    }
}
return(new db_one());
?>