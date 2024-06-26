//Class constructor($p1 : Variant; $p2 : Variant; $p3 : Variant; $p4 : Variant; $p5 : Variant; $p6 : Variant; $p7 : Variant)
Class constructor( ... )
	
	Case of 
		: (Count parameters:C259=0)  // current date
			
			This:C1470.date:=Current date:C33
			This:C1470.time:=Current time:C178
			This:C1470.milliseconds:=0
			
		: (Count parameters:C259=1)
			Case of 
				: (Value type:C1509($1)=Is text:K8:3) && (Match regex:C1019("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}Z"; $1; 1))  //"YYYY-MM-DDThh:mm:ss.nnnZ"
					This:C1470.date:=Add to date:C393(!00-00-00!; Num:C11(Substring:C12($1; 1; 4)); Num:C11(Substring:C12($1; 6; 2)); Num:C11(Substring:C12($1; 9; 2)))
					This:C1470.time:=Time:C179(Substring:C12($1; 12; 8))
					This:C1470.milliseconds:=Num:C11(Substring:C12($1; 21; 3))

				: (Value type:C1509($1)=Is date:K8:7)  // date, no time, no ms
					
					This:C1470.date:=$1
					This:C1470.time:=?00:00:00?
					This:C1470.milliseconds:=0
					
				: (Value type:C1509($1)=Is time:K8:8)  // no date, time, no ms
					
					This:C1470.time:=$1
					This:C1470.date:=!00-00-00!
					This:C1470.milliseconds:=0
					
				: (Value type:C1509($1)=Is real:K8:4)  // no date, no time, ms
					
					This:C1470.milliseconds:=$1
					This:C1470.date:=!00-00-00!
					This:C1470.time:=?00:00:00?
					
			End case 
			
		: (Count parameters:C259=2)
			
			Case of 
				: (Value type:C1509($1)=Is date:K8:7) && (Value type:C1509($2)=Is time:K8:8)  // date and time (no ms)
					
					This:C1470.date:=$1
					This:C1470.time:=$2
					This:C1470.milliseconds:=0
					
				: (Value type:C1509($1)=Is time:K8:8) && (Value type:C1509($2)=Is real:K8:4)  // (no date) time and ms 
					
					//This.date:=Current date
					This:C1470.time:=$1
					This:C1470.milliseconds:=$2
					
				: (Value type:C1509($1)=Is date:K8:7) && (Value type:C1509($2)=Is real:K8:4)  // date (no time) and ms 
					
					This:C1470.date:=$1
					//This.time:=Current time
					This:C1470.milliseconds:=$2
					
			End case 
			
			
		: (Count parameters:C259>=3)
			Case of 
					
				: (Value type:C1509($1)=Is date:K8:7) && (Value type:C1509($2)=Is time:K8:8) && (Value type:C1509($3)=Is real:K8:4)
					This:C1470.date:=$1
					This:C1470.time:=$2
					This:C1470.milliseconds:=$3
					
				: (Value type:C1509($1)=Is real:K8:4) && (Value type:C1509($2)=Is real:K8:4) && (Value type:C1509($3)=Is real:K8:4)  //yy;mm;dd{;hh{;mn{;ss{;ms}}}}
					
					This:C1470.date:=Add to date:C393(!00-00-00!; $1; $2; $3)
					
					If (Count parameters:C259>=4) && (Value type:C1509($4)=Is real:K8:4)
						This:C1470.time:=$4*3600
						If (Count parameters:C259>=5) && (Value type:C1509($5)=Is real:K8:4)
							This:C1470.time+=$5*60
							If (Count parameters:C259>=6) && (Value type:C1509($6)=Is real:K8:4)
								This:C1470.time+=$6
								If (Count parameters:C259>=7) && (Value type:C1509($7)=Is real:K8:4)
									This:C1470.milliseconds:=$7
								End if 
							End if 
						End if 
					End if 
					
			End case 
	End case 
	
	
	
Function get year()->$year : Integer  // day of month
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$year:=Year of:C25(This:C1470.date)
	End if 
	
Function get month()->$month : Integer  // day of week
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$month:=Month of:C24(This:C1470.date)
	End if 
	
Function get day()->$day : Integer  // day of month
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$day:=Day of:C23(This:C1470.date)
	End if 
	
	
Function get hours()->$hours : Integer  // hours
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$hours:=This:C1470.time\3600
	End if 
	
Function get minutes()->$minutes : Integer  // minutes
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$minutes:=(This:C1470.time-((This:C1470.time\3600)*3600))\60
	End if 
	
Function get seconds()->$seconds : Integer  // seconds
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$seconds:=This:C1470.time%60
	End if 
	
Function get dayNumber()->$dayNumber : Integer  // day of week
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$dayNumber:=Day number:C114(This:C1470.date)
	End if 
	
Function get dayName()->$dayName : Text  // day of week
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$dayName:=String:C10(This:C1470.date; "EEEE")
	End if 
	
Function get monthName()->$monthName : Text  // day of week
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$monthName:=String:C10(This:C1470.date; "MMMM")
	End if 
	
Function __splitDuration($duration : Real)->$split : Object
	
	var $negative : Boolean
	
	$split:={}
	If ($duration<0)
		$negative:=True:C214
		$duration:=Abs:C99($duration)
	End if 
	
	$split.duration:=$duration  // in global ms
	
	$split.days:=$duration\(24*3600*1000)
	$duration-=$split.days*(24*3600*1000)
	
	$split.hours:=$duration\(3600*1000)
	$duration-=$split.hours*(3600*1000)
	
	$split.minutes:=$duration\(60*1000)
	$duration-=$split.minutes*(60*1000)
	
	$split.seconds:=$duration\1000
	$duration-=$split.seconds*1000
	
	$split.milliseconds:=$duration
	
	If ($negative)
		$split.days*=-1
		$split.hours*=-1
		$split.minutes*=-1
		$split.seconds*=-1
		$split.milliseconds*=-1
		$split.duration*=-1
	End if 
	
Function minus($dateTime : cs:C1710.DateTime)->$delta : Object
	
	var $date : Date
	var $time : Time
	var $duration : Real
	
	If (Not:C34(Undefined:C82(This:C1470.date))) && (Not:C34(Undefined:C82($dateTime.date)))  // date - date
		$duration:=((This:C1470.date-$dateTime.date)*(24*3600*1000))+((This:C1470.time-$dateTime.time)*1000)+(This:C1470.milliseconds-$dateTime.milliseconds)  // positive or negative in milliseconds
		$delta:=This:C1470.__splitDuration($duration)
	End if 
	
	
Function addMilliseconds($milliseconds : Real)
	
	var $extraDays : Real
	
	This:C1470.milliseconds+=$milliseconds
	If (This:C1470.milliseconds>=1000)
		This:C1470.time+=This:C1470.milliseconds\1000
		This:C1470.milliseconds:=This:C1470.milliseconds%1000
		If (This:C1470.time>=(3600*24))
			$extraDays:=This:C1470.time\(3600*24)
			This:C1470.time:=This:C1470.time%(3600*24)
			This:C1470.date:=Add to date:C393(This:C1470.date; 0; 0; $extraDays)
		End if 
	End if 
	
Function addTime($duration : Time; $milliseconds : Real)
	
	var $extraDays : Real
	
	If (Count parameters:C259>=2)
		This:C1470.addMilliseconds($milliseconds)
	End if 
	This:C1470.time+=$duration
	If (This:C1470.time>=(3600*24))
		$extraDays:=This:C1470.time\(3600*24)
		This:C1470.time:=This:C1470.time%(3600*24)
		This:C1470.date:=Add to date:C393(This:C1470.date; 0; 0; $extraDays)
	End if 
	
Function addDate($years : Integer; $months : Integer; $days : Integer; $duration : Time; $milliseconds : Real)
	
	If (Count parameters:C259>=5)
		This:C1470.addMilliseconds($milliseconds)
	End if 
	If (Count parameters:C259>=4)
		This:C1470.addTime($duration)
	End if 
	
	This:C1470.date:=Add to date:C393(This:C1470.date; $years; $months; $days)
	
	
	
	
	
	
	
	
	
	
