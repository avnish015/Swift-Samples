//
//  BatteryStatus.swift
//  DontSleep
//
//  Created by avnish kumar on 16/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

let DSBatteryStatusUnavailable:Float = -1.0
typealias DSBatteryStatusChangeBlock = (Float)->Void

// An object that represents the current battery capacity.
class BatteryStatus: NSObject {
    
    var  runLoopSource:CFRunLoopSource?
    //An optional block that will be called when the power source changes and registerForCapacityChanges was called.
    var capacityChangeHandler:DSBatteryStatusChangeBlock?

    //Returns YES if the current device actually has a built-in battery.
    var batteryStatusAvilable:Bool{
        
        get{
            
            let powerSourceInfos = self.powerSourceInfos()
            if let _ = powerSourceInfos {
                return true
            } else {
                return false
            }
        }
    }
    
    func powerSourceInfos()->NSDictionary? {
        let blob = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sourcesList = IOPSCopyPowerSourcesList(blob).takeUnretainedValue()
        
        if CFArrayGetCount(sourcesList) == 0 {
            return nil
        }
        let powerSource = IOPSGetPowerSourceDescription(blob,unsafeBitCast(CFArrayGetValueAtIndex(sourcesList, 0),to: AnyObject.self) ).takeUnretainedValue()
        let powerInfo:NSDictionary? = powerSource
        return powerInfo
    }
    
    
//Returns the current battery charging level of the internal battery, or BatteryStatusUnavailable.
    func currentCapacity()->Float
    {
        let powerSourceInfos:NSDictionary? = self.powerSourceInfos()
        if powerSourceInfos == nil {
            return DSBatteryStatusUnavailable
        }
        if let batteryCapcity = powerSourceInfos![kIOPSCurrentCapacityKey]{
            return batteryCapcity as! Float
        } else {
            return DSBatteryStatusUnavailable
        }
    }
    
    // MARK - Capacity Change Handler
    
    /**
    *  Registers the current instance with the runloop to receive power source change notifications.
    *
    *  The capacityChangeHandler block will be called when a power source change occurs.
    */
    func registerForCapacityChangesIfNeeded()
    {
        if self.runLoopSource != nil {
            return
        }
        let  runLoopSource = IOPSNotificationCreateRunLoopSource(DSBatteryStatusChangeHandler as! IOPowerSourceCallbackType, Unmanaged.passUnretained(self).toOpaque())
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource?.takeRetainedValue(), CFRunLoopMode.defaultMode)
    
        self.runLoopSource = runLoopSource?.takeRetainedValue()
    }
    /**
     *  Unregisters the current instance from all capacity change notifications.
     *  This method will automatically be called on dealloc.
     */
    func unregisterFromCapacityChanges() {
        
        if !(self.runLoopSource != nil) {
            return
        }
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(), self.runLoopSource, CFRunLoopMode.defaultMode)
        self.runLoopSource = nil
    }
}


// MARK: - KYABatteryStatusChangeHandler
func DSBatteryStatusChangeHandler(_ context:UnsafeMutableRawPointer) {
    let batteryStatus = Unmanaged<BatteryStatus>.fromOpaque(context).takeUnretainedValue()
    if batteryStatus.capacityChangeHandler != nil {
        batteryStatus.capacityChangeHandler!(batteryStatus.currentCapacity())
    }
}

