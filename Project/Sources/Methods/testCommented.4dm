//%attributes = {}
var $dateTime : cs:C1710.DateTime
var $duration : Real
var $delta : Object

//--------------- CONSTRUCTOR : 4 CALL OPTIONS -------------------------------------------------

// no arguments -> current date + current time + 0ms
$dateTime:=cs:C1710.DateTime.new()
// 4D like
$dateTime:=cs:C1710.DateTime.new(!2001-02-03!; ?15:30:45?; 456)  // date + time + ms
// Javascript like 
$dateTime:=cs:C1710.DateTime.new(2001; 2; 3; 15; 30; 45; 456)
// two strings (== parse)
//$dateTime:=cs.DateTime.new("2001-FEB-3 15:30:45"; "YYYY-MMM-DD HH:mm:ss")


//--------------------------- calculated properties---------------------------

$dateTime.year
$dateTime.month
$dateTime.day
$dateTime.hours
$dateTime.minutes
$dateTime.seconds
$dateTime.dayNumber  // 1…7
$dateTime.dayName  // sunday, monday, tuesday == string($dateTime.date;"EEEE")
$dateTime.monthName  // january; february, march  == string($dateTime.date;"MMMM")
// ++ Japanese


//---------------------------ADD DATE-------------------------------------
$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!)
$dateTime1.addDate(1; 1; 1; ?23:59:59?; 999)  // 2002-02-02 23:59:59 999

////---------------------------ADD TIME-------------------------------------
$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!; ?23:59:59?)
$dateTime1.addTime(?00:00:01?)  // 2002-02-02 00:00:00

////---------------------------{ADD MILLISECONDS}-------------------------------------
$dateTime1:=cs:C1710.DateTime.new(!2001-01-01!; ?23:59:59?; 999)
$dateTime1.addMilliseconds(1)  // 2002-02-02 00:00:00 000

//---------------------------MINUS-----------(returns an object)--------------------------

$dateTime1:=cs:C1710.DateTime.new(!2000-01-01!; ?10:12:41?; 345)  //10h12'41" 345ms
$dateTime2:=cs:C1710.DateTime.new(!2000-01-01!; ?15:33:45?; 567)  //  15h33'45" 567ms
$delta:=$dateTime2.minus($dateTime1)  //

// global duration in ms
$delta.duration
// splitted into days/hours/etc…
$delta.days
$delta.hours
$delta.minuts
$delta.seconds
$delta.milliseconds

//--------------------------- PARSE ------------------------------------- == constructor but applyed on an existing DateTime
//$dateTime:=cs.DateTime.new()
//$dateTime:=cs.DateTime.parse("2001-FEB-3 15:30:45"; "YYYY-MMM-DD HH:mm:ss")





