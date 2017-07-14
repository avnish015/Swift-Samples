//
//  AppController.swift
//  DontSleep
//
//  Created by avnish kumar on 01/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

class AppController: NSObject,NSMenuDelegate,NSUserNotificationCenterDelegate {
    //The associated SleepWakeTimer instance of this app controller.
    var sleepWakeTimer:SleepWakeTimer!
    var batteryStatus:BatteryStatus!
    var batteryOverrideEnabled:Bool = false
    
    
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var timerMenu: NSMenu!
    
    // Status Item
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override init() {
        
        super.init()
        self.configureStatusItem()
        self.batteryStatus = BatteryStatus()
        self.batteryStatus.capacityChangeHandler = { [weak self]
            (capacity:Float)->Void in
            self?.batteryCapacityDidChange(capacity)
        }
        
        self.sleepWakeTimer=SleepWakeTimer()
        self.sleepWakeTimer.addObserver(self, forKeyPath:Constant.scheduled, options:NSKeyValueObservingOptions.new, context:nil)
       
        if shouldActivateOnLaunch() {
            self .activateTimer()
        }
       self.configureBatteryStatus()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit{
        
       NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: Constant.batteryCapacityThresholdDidChangeNotification), object: nil)
    }

    func configureStatusItem() {
        statusItem.highlightMode = !UserDefaults.standard.bool(forKey: DSUserDefaultsKeyMenuBarIconHighlightDisabled)
        if let button = statusItem.button {
            button.target = self
            button.image = NSImage(named:Constant.activeIcon)
            button.action = #selector(AppController.toggleStatus)
            
            //Left click for activate or deactivate the app right click for options
            button.sendAction(on: NSEventMask(rawValue: UInt64(Int(NSEventMask.leftMouseUp.rawValue)|Int(NSEventMask.rightMouseUp.rawValue))))
            
            self.setStatusItemActive(false)
        }
    }
    
    func configureBatteryStatus() {
        
        if !self.batteryStatus.batteryStatusAvilable {
            return
        }
    
        NotificationCenter.default.addObserver(self, selector: #selector(AppController.batteryCapacityThresholdDidChange(_:)), name: NSNotification.Name(rawValue: Constant.batteryCapacityThresholdDidChangeNotification), object: nil)
    
        // Start receiving battery status changes
        if UserDefaults.standard.batteryCapacityThresholdEnabled {
            self.batteryStatus.registerForCapacityChangesIfNeeded()
        }
    }
   
// MARK: - Battery Capacity Threshold Changes
    func batteryCapacityThresholdDidChange(_ notification:Notification) {
        if !self.batteryStatus.batteryStatusAvilable {
            return
        }
        self.terminateTimer()
    }
    
    func checkAndEnableBatteryOverride() {
        let currentCapacity = self.batteryStatus.currentCapacity()
        let threshold = UserDefaults.standard.batteryCapacityThreshold
        self.batteryOverrideEnabled = currentCapacity <= threshold
    }
    
    func disableBatteryOverride() {
        self.batteryOverrideEnabled = false
    }
    
    func batteryCapacityDidChange(_ capacity:Float) {
        let threshold = UserDefaults.standard.batteryCapacityThreshold
        
        if self.sleepWakeTimer.isScheduled() && (capacity <= threshold) && !self.batteryOverrideEnabled  {
            self.terminateTimer()
        }
    }
    
    func shouldActivateOnLaunch()->Bool {
        return UserDefaults.standard.activateOnLaunch
    }
    
    @IBAction func toggleActivateOnLaunch(_ sender:AnyObject) {
        let defaults = UserDefaults.standard
        defaults.activateOnLaunch = !defaults.activateOnLaunch
        defaults.synchronize()
    }
    
// MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
        if (object! as AnyObject).isEqual(self.sleepWakeTimer) && keyPath == Constant.scheduled {
            self.setStatusItemActive(((change![NSKeyValueChangeKey.newKey] as AnyObject).boolValue)!)
        }
    }
    

    func activateTimerWithTimeInterval(_ timeInterval:TimeInterval) {
        // Do not allow negative time intervals
        if timeInterval < 0 {
            return
        }
    
        // Check battery overrides and register for capacity changes.
        self.checkAndEnableBatteryOverride()
        if UserDefaults.standard.batteryCapacityThresholdEnabled {
            self.batteryStatus.registerForCapacityChangesIfNeeded()
        }
        self.sleepWakeTimer.scheduleWithTimeInterval(timeInterval) { (cancelled:Bool) -> Void in
        }
    }
    
    func setStatusItemActive(_ active:Bool) {
        let button = self.statusItem.button
        let menubarIcon = MenuBarIcon.currentIcon()
        
        if active {
            button!.image = menubarIcon.activeIcon
            button!.toolTip = NSLocalizedString("Click to allow sleep\nRight click to show menu", comment: Constant.emptyString)
        } else {
            button!.image = menubarIcon.inactiveIcon
            button!.toolTip = NSLocalizedString("Click to prevent sleep\nRight click to show menu", comment: Constant.emptyString)
        }
    }

    
    func showMenu() {
        self.statusItem.popUpMenu(self.menu)
    }
    
    // Action for status item
    func toggleStatus() {
        let event = NSApplication.shared().currentEvent
        
        if event!.modifierFlags.contains(NSEventModifierFlags.control) || event!.type == NSEventType.rightMouseUp {
            self.showMenu()
        } else if self.sleepWakeTimer.isScheduled() {
            self.terminateTimer()
        } else {
            self.activateTimer()
        }
    }
    
    func terminateTimer()->Void {
    
        self.disableBatteryOverride()
        self.batteryStatus.unregisterFromCapacityChanges()
        
        if self.sleepWakeTimer.isScheduled() == true {
            self.sleepWakeTimer.invalidate()
        }
    }
    
    func activateTimer()->Void  {
        self.activateTimerWithTimeInterval(self.defaultTimeInterval())
    }
    

    
    @IBAction func selectTimeInterval(_ sender: NSMenuItem) {
        
        self.terminateTimer()
        if sender.isAlternate {
            self.setDefaultTimeInterval(TimeInterval(sender.tag))
        }
        else {
            
            DispatchQueue.main.async(execute: {[weak self] () -> Void in
                
                let seconds = sender.tag
                self!.activateTimerWithTimeInterval(TimeInterval(seconds))
                })
        }
    }
    
    // Update the selected menu item and timer countdown menu item
    func menuNeedsUpdate(_ menu: NSMenu) {
        
        if !menu.isEqual(self.timerMenu) {
            return
        }
    
        for item in menu.items {
            
            item.state = NSOffState
            let seconds = TimeInterval(item.tag)
            if seconds > 0 {
                if self.sleepWakeTimer.scheduledTimeInterval == seconds {
                    item.state = NSOnState
                }
            } else if seconds == 0 && !item.isSeparatorItem {
                item.state = NSOffState
                if self.sleepWakeTimer.isScheduled() && (self.sleepWakeTimer.scheduledTimeInterval == SleepWakeTimeIntervalIndefinite) {
                    item.state = NSOnState
                }
            } else {
                // It will display the timer countdown menu item
                item.isHidden = true
                if self.sleepWakeTimer.fireDate != nil {
                    item.isHidden = false
                    let dateFormatter = DateComponentsFormatter()
                    dateFormatter.unitsStyle = .short
                    dateFormatter.allowedUnits = NSCalendar.Unit(rawValue: NSCalendar.Unit.second.rawValue | NSCalendar.Unit.minute.rawValue | NSCalendar.Unit.hour.rawValue)
                    dateFormatter.includesTimeRemainingPhrase = true
                    item.title = dateFormatter.string(from: Date(), to: self.sleepWakeTimer.fireDate! as Date)!
                }
            }
        }
    }

   //MARK: Default Time Interval
    func defaultTimeInterval()->TimeInterval {
       return UserDefaults.standard.defaultTimeInterval
    }
    
    func setDefaultTimeInterval(_ interval:TimeInterval) {
        UserDefaults.standard.defaultTimeInterval = interval
    }
}
