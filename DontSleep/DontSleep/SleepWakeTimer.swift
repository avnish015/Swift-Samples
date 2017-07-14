//
//  SleepWakeTimer.swift
//  DontSleep
//
//  Created by avnish kumar on 03/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

let DS_MINUTES = 60.0
let DS_HOURS = 3600.0

let DS_10SECS = 10.0
let DS_5MINS = 5*DS_MINUTES
let DS_10MINS = 10*DS_MINUTES
let DS_15MINS = 15*DS_MINUTES
let DS_30MINS = 30*DS_MINUTES
let DS_1HOUR = 1*DS_HOURS
let DS_2HOURS = DS_HOURS*2
let DS_5HOURS = DS_HOURS*5


typealias DSSleepWakeTimerCompletionBlock = (Bool)->Void

let SleepWakeTimeIntervalIndefinite = 0.0



class SleepWakeTimer: NSObject {
    
    /**
    *  Returns the completion date for the currently scheduled timer.
    *
    *  If the timer was scheduled for 0 seconds (Infinity), the fireDate is nil.
    */
    var fireDate:Date?
    
    /**
    *  The initial time interval that was set to schedule the timer.
    */
    var scheduledTimeInterval:TimeInterval?

    /**
    *  Returns YES if a task is scheduled and running.
    */
    var scheduled:Bool?
    
    /**
    *  An optional completion block when the task finishes at the fireDate
    *  or when invalidate is called manually.
    */
    var  completionBlock:DSSleepWakeTimerCompletionBlock?

    var  caffeinateTask:Process?
    
    
    override init() {
        super.init()

            // Terminate all remaining tasks on app quit
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSApplicationWillTerminate, object: nil, queue: nil, using:{[weak self] (note:Notification) in
            self!.invalidate()
        })
    }
    
    deinit {
        self.invalidate()
    }
    
    //MARK: - Scheduling
    
    func scheduleWithTimeInterval(_ timeInterval:TimeInterval, completion:DSSleepWakeTimerCompletionBlock!) {

        self.completionBlock = completion
        // Set the fireDate
        self.scheduledTimeInterval = timeInterval
        if timeInterval != SleepWakeTimeIntervalIndefinite {
            self.fireDate = Date(timeIntervalSinceNow: timeInterval)
        }
        // Spawn caffeinate
        self.spawnCaffeinateTaskForTimeInterval(timeInterval)
    }
    
    func invalidate() {
        fireDate = nil
        self.scheduledTimeInterval = SleepWakeTimeIntervalIndefinite
        self.terminateCaffeinateTask()
    }
    
    func isScheduled()->Bool {
        if self.caffeinateTask != nil && self.caffeinateTask!.isRunning {
            return true
        }
        return false
    }
    
    // MARK: - Caffeinate Task Handling
    func spawnCaffeinateTaskForTimeInterval(_ timeInterval:TimeInterval) {
        var arguments:[String] = Array()
        
        if UserDefaults.standard.bool(forKey: DSUserDefaultsKeyAllowDisplaySleep) {
            arguments.append("-s")
        }else {
            arguments.append("-di")
        }
        
        if timeInterval != SleepWakeTimeIntervalIndefinite {
            
            arguments.append("-t \(timeInterval)")
        }
        
        arguments.append("-w \(ProcessInfo.processInfo.processIdentifier)")
        self.willChangeValue(forKey: Constant.scheduled)
        caffeinateTask = Process.launchedProcess(launchPath: "/usr/bin/caffeinate", arguments:arguments)
        //terminate Handler
        self.caffeinateTask!.terminationHandler = {[weak self] (task:Process)->Void in
            self!.invalidateScheduledTimer()
        }
        self.didChangeValue(forKey: Constant.scheduled)
    }
    
    //Terminate caffeinate with force
    func terminateCaffeinateTask() {
        if let caffeinateTask = caffeinateTask {
            caffeinateTask.terminationHandler = nil
            caffeinateTask.terminate()
            self.invalidateScheduledTimer()
        }
    }
    
    func invalidateScheduledTimer() {
        self.willChangeValue(forKey: Constant.scheduled)
        self.caffeinateTask = nil
        self.scheduledTimeInterval = SleepWakeTimeIntervalIndefinite
        self.fireDate = nil
        self.didChangeValue(forKey: Constant.scheduled)
    }
}
