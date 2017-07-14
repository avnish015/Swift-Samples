//
//  NSUserDefaults+Keys.swift
//  DontSleep
//
//  Created by avnish kumar on 10/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Foundation

let DSUserDefaultsKeyActivateOnLaunch = "info.DontSleep.ActivateOnLaunch"
let DSUserDefaultsKeyNotificationsEnabled = "info.DontSleep.NotificationsEnabled"
let DSUserDefaultsKeyDefaultTimeInterval = "info.DontSleep.TimeInterval"
let DSUserDefaultsKeyAllowDisplaySleep = "info.DontSleep.AllowDisplaySleep"
let DSUserDefaultsKeyMenuBarIconHighlightDisabled = "info.DontSleep.MenuBarIconHighlightDisabled"
let DSUserDefaultsKeyBatteryCapacityThresholdEnabled = "info.DontSleep.BatteryCapacityThresholdEnabled"
let DSUserDefaultsKeyBatteryCapacityThreshold = "info.DontSleep.BatteryCapacityThreshold"
let DSUserDefaultsKeyLaunchAtLogin = "info.DontSleep.LaunchAtLogin"


extension UserDefaults
{
    var activateOnLaunch:Bool
    {
        set{

            set(newValue, forKey: DSUserDefaultsKeyActivateOnLaunch)
        }
        get{
            
            return bool(forKey: DSUserDefaultsKeyActivateOnLaunch)
        }
    }
    
    var defaultTimeInterval:TimeInterval
    {
        set{
            
            set(Int(newValue), forKey: DSUserDefaultsKeyDefaultTimeInterval)
        }
        get{
            
            return TimeInterval(integer(forKey: DSUserDefaultsKeyDefaultTimeInterval))
        }
    }
    
    var notificationsEnabled:Bool
    {
        set{
            
            set(newValue, forKey: DSUserDefaultsKeyNotificationsEnabled)
        }
        get{
            return bool(forKey: DSUserDefaultsKeyNotificationsEnabled)
        }
    }
    
        var allowDisplaySleep:Bool
        {
            set{
                
                set(newValue, forKey: DSUserDefaultsKeyAllowDisplaySleep)
            }
            get{
                
                return bool(forKey: DSUserDefaultsKeyAllowDisplaySleep)
            }
        }
    
        var menuBarIconHighlightDisabled:Bool
        {
            set{
                
                set(newValue, forKey: DSUserDefaultsKeyMenuBarIconHighlightDisabled)
            }
            get{
                return bool(forKey: DSUserDefaultsKeyMenuBarIconHighlightDisabled)
            }
        }
    
        var batteryCapacityThresholdEnabled:Bool
        {
            set{
            
                set(newValue, forKey: DSUserDefaultsKeyBatteryCapacityThresholdEnabled)
            }
            get{
            
                return bool(forKey: DSUserDefaultsKeyBatteryCapacityThresholdEnabled)

            }
        }
    
        var batteryCapacityThreshold:Float
        {
            set{
            
                set(newValue, forKey: DSUserDefaultsKeyBatteryCapacityThreshold)
            }
            get{
                
                let threshold = float(forKey: DSUserDefaultsKeyBatteryCapacityThreshold)
                return max(threshold, 10.0)

            }
        }
    
}
