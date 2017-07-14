//
//  ActivationDuration.swift
//  DontSleep
//
//  Created by avnish kumar on 11/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

let DSActivationDurationIndefinite = 0
class ActivationDuration: NSObject {

    var seconds:TimeInterval
    var displayUnit:NSCalendar.Unit
    var localizedTitle:NSString{
        get{
            
            let interval = self.seconds
            if(interval == 0) {
                return NSLocalizedString(Constant.indefinitely, tableName: nil, comment:Constant.emptyString) as NSString
            }
            let formatter = self.sharedDateComponentsFormatter()
            formatter.allowedUnits = self.displayUnit
            return formatter.string(from: interval)! as NSString
        }
    }
    
    override var description: String {
        
        get{
            return "\(super.description) (\(self.localizedTitle))"
        }
    }
    
     init(seconds:TimeInterval) {
        self.seconds = seconds
        self.displayUnit = NSCalendar.Unit.second
        super.init()
     }
    
    init(seconds:TimeInterval, displayUnit:NSCalendar.Unit) {
        self.seconds = seconds
        self.displayUnit = displayUnit
        super.init()
    }
    
   //  MARK: - Localized Formatter
    func sharedDateComponentsFormatter()->DateComponentsFormatter {
        let sharedFormatter:DateComponentsFormatter?
        sharedFormatter = DateComponentsFormatter()
        sharedFormatter!.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        return sharedFormatter!
    }
}

// MARK: - Convenience Helper Functions

func DSMinutesToSeconds(_ minutes:NSInteger)->TimeInterval {
    return TimeInterval(Float(minutes) * 60.0)
}

func DSHoursToSeconds(_ hours:NSInteger)->TimeInterval {
    return TimeInterval(Float(hours) * 3600.0)
}


func  DSDurationForSeconds(_ seconds:Int)->ActivationDuration {
    return ActivationDuration(seconds: TimeInterval(seconds))
}

func DSDurationForMinutes(_ minutes:NSInteger)->ActivationDuration {
    return ActivationDuration(seconds: DSMinutesToSeconds(minutes), displayUnit: NSCalendar.Unit.minute)
}

func  DSDurationForHours(_ hours:NSInteger)->ActivationDuration {
    return ActivationDuration(seconds: DSHoursToSeconds(hours), displayUnit: NSCalendar.Unit.hour)
}

