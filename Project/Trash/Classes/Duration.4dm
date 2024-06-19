//Class constructor($p1 : Variant; $p2 : Variant; $p3 : Variant; $p4 : Variant; $p5 : Variant; $p6 : Variant; $p7 : Variant)
Class constructor( ... )
	
	Case of 
		: (Count parameters:C259=0)  // current date
			
			This:C1470.duration:=0
			
		: (Count parameters:C259=1)
			Case of 
				: (Value type:C1509($1)=Is date:K8:7)  // date, no time, no ms
					This:C1470.date:=$1
					This:C1470.time:=?00:00:00?
					This:C1470.duration:=0
					
				: (Value type:C1509($1)=Is time:K8:8)  // duration in time
					This:C1470.duration:=$1*1000
					
				: (Value type:C1509($1)=Is real:K8:4)  // duration in real (ms!)
					This:C1470.duration:=$1
					
			End case 
			
		: (Count parameters:C259=2)
			
			Case of 
				: (Value type:C1509($1)=Is date:K8:7) && (Value type:C1509($2)=Is time:K8:8)  // date and time no ms
					This:C1470.date:=$1
					This:C1470.time:=$2
					
				: (Value type:C1509($1)=Is time:K8:8) && (Value type:C1509($2)=Is real:K8:4)  // duration in time + ms
					This:C1470.duration:=($1*1000)+$2
					
				: (Value type:C1509($1)=Is real:K8:4) && (Value type:C1509($2)=Is time:K8:8)  // duration in days + time 
					This:C1470.duration:=($1*24*3600*1000)+($2*1000)
					
			End case 
			
			
		: (Count parameters:C259>=3)
			Case of 
					
				: (Value type:C1509($1)=Is date:K8:7) && (Value type:C1509($2)=Is time:K8:8) && (Value type:C1509($3)=Is real:K8:4)
					This:C1470.date:=$1
					This:C1470.time:=$2
					This:C1470.duration:=$3
					
				: (Value type:C1509($1)=Is real:K8:4) && (Value type:C1509($2)=Is time:K8:8) && (Value type:C1509($3)=Is real:K8:4)  // duration in days time + ms
					This:C1470.duration:=($1*24*3600*1000)+($2*1000)+$3
					
				: (Value type:C1509($1)=Is real:K8:4) && (Value type:C1509($2)=Is real:K8:4) && (Value type:C1509($3)=Is real:K8:4)  //yy;mm;dd{;hh{;mn{;ss{;ms}}}}
					
					This:C1470.date:=!00-00-00!
					This:C1470.time:=?00:00:00?
					This:C1470.duration:=0
					
					This:C1470.date:=Add to date:C393(This:C1470.date; $1; $2; $3)
					
					If (Count parameters:C259>=4) && (Value type:C1509($4)=Is real:K8:4)
						This:C1470.time+=$4*3600
						If (Count parameters:C259>=5) && (Value type:C1509($5)=Is real:K8:4)
							This:C1470.time+=$5*60
							If (Count parameters:C259>=6) && (Value type:C1509($6)=Is real:K8:4)
								This:C1470.time+=$6
								If (Count parameters:C259>=7) && (Value type:C1509($7)=Is real:K8:4)
									This:C1470.duration:=$7
								End if 
							End if 
						End if 
					End if 
					
			End case 
	End case 
	
	
	
Function splitDuration($duration : Real)->$split : Object
	
	var $negative : Boolean
	
	$split:={}
	If ($duration<0)
		$negative:=True:C214
		$duration:=Abs:C99($duration)
	End if 
	
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
	End if 
	
	//Function getFullYear()->$year : Integer
	//$year:=Year of(This.date)
	
	//Function getMonth()->$month : Integer
	//$month:=Month of(This.date)
	
	//Function getDate()->$dayOfMonth : Integer  // day of month
	//$dayOfMonth:=Day of(This.date)
	
	//Function getDay()->$dayOfWeek : Integer  // day of week
	//$dayOfWeek:=Day number(This.date)
	
	
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
	
Function get days()->$days : Integer
	If (Not:C34(Undefined:C82(This:C1470.duration)))
		$days:=This:C1470.splitDuration(This:C1470.duration).days
	End if 
	
Function get dayNumber()->$dayNumber : Integer  // day of week
	If (Not:C34(Undefined:C82(This:C1470.date)))
		$dayNumber:=Day number:C114(This:C1470.date)
	End if 
	
Function get hours()->$hours : Integer  // hours
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$hours:=This:C1470.time\3600
	Else 
		If (Not:C34(Undefined:C82(This:C1470.duration)))
			$hours:=This:C1470.splitDuration(This:C1470.duration).hours
		End if 
	End if 
	
Function get minutes()->$minutes : Integer  // minutes
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$minutes:=(This:C1470.time-((This:C1470.time\3600)*3600))\60
	Else 
		If (Not:C34(Undefined:C82(This:C1470.duration)))
			$minutes:=This:C1470.splitDuration(This:C1470.duration).minutes
		End if 
	End if 
	
Function get seconds()->$seconds : Integer  // seconds
	If (Not:C34(Undefined:C82(This:C1470.time)))
		$seconds:=This:C1470.time%60
	Else 
		If (Not:C34(Undefined:C82(This:C1470.duration)))
			$seconds:=This:C1470.splitDuration(This:C1470.duration).seconds
		End if 
	End if 
	
	
Function get milliseconds()->$milliSeconds : Integer  // seconds
	If (Not:C34(Undefined:C82(This:C1470.duration)))
		$milliSeconds:=This:C1470.splitDuration(This:C1470.duration).milliseconds
	End if 
	
	
	
Function minus($dateTime : cs:C1710.DateTime)->$delta : cs:C1710.DateTime
	var $date : Date
	var $time : Time
	var $duration : Real
	
	$duration:=0
	Case of 
		: (Not:C34(Undefined:C82(This:C1470.date))) && (Not:C34(Undefined:C82($dateTime.date)))  // date - date
			$duration:=((This:C1470.date-$dateTime.date)*(24*3600*1000))+((This:C1470.time-$dateTime.time)*1000)+(This:C1470.milliseconds-$dateTime.milliseconds)  // positive or negative in milliseconds
			$delta:=cs:C1710.DateTime.new($duration)
			
		: (Not:C34(Undefined:C82(This:C1470.date))) && (Not:C34(Undefined:C82($dateTime.duration)))  // date - duration
			If (Undefined:C82(This:C1470.time))
				This:C1470.time:=?00:00:00?
			End if 
			If (Undefined:C82(This:C1470.duration))
				This:C1470.duration:=0  // stands for milliseconds when date+time
			End if 
			
			$split:=This:C1470.splitDuration($dateTime.duration)
			This:C1470.duration-=$split.milliseconds
			This:C1470.time-=($split.hours*3600)+($split.minutes*60)+($split.seconds)
			If (This:C1470.duration<0)
				This:C1470.duration+=1000  // +1000ms to be postive again
				This:C1470.time-=1  // and remove one mode second
			End if 
			If (This:C1470.time<0)
				This:C1470.time+=(24*3600)  // add 24 hours to be positive again
				$split.days+=1  // add one day to be removed
			End if 
			
			$date:=Add to date:C393(This:C1470.date; 0; 0; -$split.days)
			$time:=This:C1470.time
			$duration:=This:C1470.duration
			
			$delta:=cs:C1710.DateTime.new($date; $time; $duration)
			
		: (Not:C34(Undefined:C82(This:C1470.duration))) && (Not:C34(Undefined:C82($dateTime.duration)))  // duration - duration
			
			$delta:=cs:C1710.DateTime.new(This:C1470.duration-$dateTime.duration)
			
	End case 
	
Function plus($dateTime : cs:C1710.DateTime)->$delta : cs:C1710.DateTime
	
	var $date : Date
	var $time : Time
	var $duration : Real
	
	Case of 
			
		: (Not:C34(Undefined:C82(This:C1470.date))) && (Not:C34(Undefined:C82($dateTime.duration)))  // date + duration
			If (Undefined:C82(This:C1470.time))
				This:C1470.time:=?00:00:00?
			End if 
			If (Undefined:C82(This:C1470.duration))
				This:C1470.duration:=0  // stands for milliseconds when date+time
			End if 
			
			$split:=This:C1470.splitDuration($dateTime.duration)
			This:C1470.duration+=$split.milliseconds
			This:C1470.time+=($split.hours*3600)+($split.minutes*60)+($split.seconds)
			
			If (This:C1470.duration>=1000)
				This:C1470.duration-=1000  // remove 1000ms to be in 0-999 range again
				This:C1470.time+=1  // and add one mode second
			End if 
			
			If (This:C1470.time>(24*3600))  // more than one day)
				This:C1470.time-=(24*3600)  // remove 24 hours to be in 00:00:00-23:59:59 range again
				$split.days+=1  //  one day more to be added
			End if 
			
			$date:=Add to date:C393(This:C1470.date; 0; 0; $split.days)
			$time:=This:C1470.time
			$duration:=This:C1470.duration
			
			$delta:=cs:C1710.DateTime.new($date; $time; $duration)
			
		: (Not:C34(Undefined:C82(This:C1470.duration))) && (Not:C34(Undefined:C82($dateTime.duration)))  // duration + duration
			
			$delta:=cs:C1710.DateTime.new(This:C1470.duration+$dateTime.duration)
			
	End case 
	
	
	
	
	
	
	
	
	
	
	
	
	