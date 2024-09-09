//%attributes = {}
var $dateTime : cs:C1710.DateTime
var $duration : Real
var $delta : Object

//----------------------------------------------------------------

$dateTime:=cs:C1710.DateTime.new()  // current date + time + ms



$dateTime:=cs:C1710.DateTime.new(!2001-02-03!)  //only date no time, no ms
$dateTime:=cs:C1710.DateTime.new(!2001-02-03!; ?15:30:45?)  // date + time
$dateTime:=cs:C1710.DateTime.new(!2001-02-03!; ?15:30:45?; 456)  // date + time + ms

$dateTime:=cs:C1710.DateTime.new(2001; 2; 3)  // Like JS except 3 mandatoy instead of two
$dateTime:=cs:C1710.DateTime.new(2001; 2; 3; 15)
$dateTime:=cs:C1710.DateTime.new(2001; 2; 3; 15; 30)
$dateTime:=cs:C1710.DateTime.new(2001; 2; 3; 15; 30; 45)
$dateTime:=cs:C1710.DateTime.new(2001; 2; 3; 15; 30; 45; 456)

// two strings 
//$dateTime:=cs.DateTime.new("2001-FEB-3 15:30:45"; "YYYY-MMM-DD HH:mm:ss")


//---------------------------MINUS-------------------------------------

$dateTime1:=cs:C1710.DateTime.new(!2000-01-01!; ?10:12:41?; 345)  //10h12'41" 345ms
$dateTime2:=cs:C1710.DateTime.new(!2000-01-01!; ?15:33:45?; 567)  //  15h33'45" 567ms
$delta:=$dateTime2.minus($dateTime1)  //
$delta:=$dateTime1.minus($dateTime2)  // 


//---------------------------ADD DATE-------------------------------------

$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addDate(1; 1; 1; ?23:59:59?; 999)  // 2002-02-02 23:59:59 999
$dateTime1.addDate(0; 0; 0; ?00:00:00?; 1)  // 2002-02-03 00:00:00 0
$dateTime1.addDate(0; 0; 0; ?30:00:00?; 1)  // 2002-02-04 06:00:00 0

$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addDate(0; 0; 0; ?00:00:00?; (3600*24*1000))  // + 1 day in milliseconds


////---------------------------ADD TIME-------------------------------------

$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addTime(?23:59:59?; 999)  // 2002-02-02 23:59:59 999
$dateTime1.addTime(?00:00:00?; 1)  // 2002-02-03 00:00:00 0
$dateTime1.addTime(?12:00:00?)

////---------------------------{ADD MILLISECONDS}-------------------------------------

$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addMilliseconds(999)  // 2002-02-02 00:00:00 999
$dateTime1.addMilliseconds(1)  // 2002-02-02 00:00:01 00

$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addMilliseconds(3600*24*1000)  // + 1 day in milliseconds


//--------------------------- PARSE -------------------------------------
//$dateTime:=cs.DateTime.new()
//$dateTime:=cs.DateTime.parse("2001-FEB-3 15:30:45"; "YYYY-MMM-DD HH:mm:ss")









