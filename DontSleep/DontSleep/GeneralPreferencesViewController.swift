//
//  GeneralPreferencesViewController.swift
//  DontSleep
//
//  Created by avnish kumar on 10/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa
import ServiceManagement


class GeneralPreferencesViewController: NSViewController {
    
     @IBOutlet var startAtLoginCheckBoxButton: NSButton!
    
    // Pre-populate the activation durations
    let activationDurations = [DSDurationForSeconds(DSActivationDurationIndefinite),DSDurationForMinutes(5),DSDurationForMinutes(10),DSDurationForMinutes(15),DSDurationForMinutes(30),DSDurationForHours(1),DSDurationForHours(2),DSDurationForHours(5)]
    
    
    // MARK - Selected Activation Duration
    var selectedActivationDuration:ActivationDuration{
        
        get{
            
            let storedDefaultInterval = UserDefaults.standard.defaultTimeInterval
            let defaultDurations = self.activationDurations.filter { (activationDuration) -> Bool in
                
                if(activationDuration.seconds == storedDefaultInterval) {
                    return true
                } else{
                    return false
                }
            }
            return defaultDurations.first!
        }
        set{
            
            self.willChangeValue(forKey: KeyName.selectedActivationDuration)
            UserDefaults.standard.defaultTimeInterval = newValue.seconds
            
            UserDefaults.standard.synchronize()
            self.didChangeValue(forKey: KeyName.selectedActivationDuration)
        }
    }
    
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: DSUserDefaultsKeyLaunchAtLogin) == true {
            startAtLoginCheckBoxButton.state = NSOnState
        } else {
            startAtLoginCheckBoxButton.state = NSOffState
        }
        
        
    }
    
    override func viewWillAppear() {
        
        super.viewWillAppear()
        self.preferredContentSize = self.view.fittingSize
    }
    
    
    /*ServiceManagement framework’s method called SMLoginItemSetEnabled. The first parameter in this method is a CFString containing the bundle identifier of the Helper application(DontSleepHelperApp). The second parameter is a BOOL indicating whether the Helper should launch at login or not. TRUE means that it will launch at login, while FALSE means that it won’t launch at login.
    */

    @IBAction func startAtLoginPreferencesChanged(_ sender: NSButton) {
        
        if !SMLoginItemSetEnabled(BundleIdentifier.helperApp as CFString,sender.state == NSOnState) {
            print("UnSuccessful")
        }
        else {
            UserDefaults.standard.set(sender.state == NSOnState, forKey: DSUserDefaultsKeyLaunchAtLogin)
        }
    }
}
