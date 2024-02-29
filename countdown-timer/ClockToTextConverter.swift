import Foundation

class ClockToTextConverter: TimeConverter {
    
    var DAY = 86400.0;
    var HOUR = 3600.0;
    var MINUTE = 60.0;
    
    var remainingTime: Double = 0;
    var clock: Clock;
    
    var seconds: Int = 0;
    var minutes: Int = 0;
    var hours: Int = 0;
    var days: Int = 0;
    
    var formattedTime: String = "00:00:00:00";
    
    init(clock: Clock){
        self.clock = clock;
        self.remainingTime = Double(clock.remainingTime);
        setFormattedTime();
    }
    
    func setFormattedTime(){
        
        days = Int(floor(remainingTime / DAY));
        hours = Int(floor(((remainingTime - (Double(days) * DAY)) / HOUR)));
        
        let daysSeconds = (Double(days) * DAY )
        let hoursSeconds = (Double(hours) * HOUR)
        
        minutes = Int(floor( (remainingTime - (daysSeconds + hoursSeconds)) / MINUTE ));
        
        let minutesSeconds = (Double(minutes) * MINUTE)
        
        seconds = Int(floor(remainingTime - ( daysSeconds + hoursSeconds + minutesSeconds )));
 
        refreshRemainingTime();
        
    }
    
    func handleDaysDecrease(){
        if days > 0 {
            days -= 1;
        } else {
            days = 0;
        }
    }
    
    func handleHoursDecrease(){
        if hours > 0 {
            hours -= 1;
        } else if hours == 0 && days > 0 {
            hours = 23;
            handleDaysDecrease();
        } else {
            hours = 0;
        }
        refreshRemainingTime();
    }
    
    func handleMinutesDecrease(){
        if minutes > 0 {
            minutes -= 1;
        } else if minutes == 0 && (hours > 0 || days > 0){
            minutes = 59;
            handleHoursDecrease();
        }
        else {
            minutes = 0;
        }
        refreshRemainingTime();
    }
    
    func handleSecondsDecrease(){
        if seconds > 0 {
            seconds -= 1;
            remainingTime -= 1;
        } else if seconds == 0 && (minutes > 0 || hours > 0 || days > 0){
            seconds = 59;
            handleMinutesDecrease();
        } else {
            seconds = 0;
        }
        refreshRemainingTime();
    }
    
    func refreshRemainingTime(){
        self.formattedTime = "\(parseNumber(value: days)):\(parseNumber(value: hours)):\(parseNumber(value: minutes)):\(parseNumber(value: seconds))";
    }
    
    func parseNumber(value: Int) -> String{
        if value <= 9 {
            return "0\(value)"
        } else { return "\(value)" };
    }
    
}
