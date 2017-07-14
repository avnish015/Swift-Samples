//
//  AdvancedPreferencesViewController.swift
//  DontSleep
//
//  Created by avnish kumar on 10/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

class AdvancedPreferencesViewController: NSViewController {

    var preferences:Array<Preference> = []
    
    // Determines if the current Mac has a built-in battery.
    var batteryStatusAvailable:Bool = BatteryStatus().batteryStatusAvilable
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configureAdvancedPreferences()
    }
    
    override func viewWillAppear() {
        self.preferredContentSize = self.view.fittingSize
    }
    
    func configureAdvancedPreferences() {
        var preferences = Array<Preference>()
        preferences.append(Preference(title: "Allow the display to sleep (when connected to AC power)", defaultKey: DSUserDefaultsKeyAllowDisplaySleep))
        preferences.append(Preference(title: "Disable menu bar icon highlight color",defaultKey:DSUserDefaultsKeyMenuBarIconHighlightDisabled))
        self.preferences = preferences
    }
    
    // MARK: - Battery Status Preferences
    
    @IBAction func batteryStatusPreferencesChanged(_ sender:AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.batteryCapacityThresholdDidChangeNotification), object: nil)
    }

    
    // MARK: -Table View Delegate & Data Source
    
    func numberOfRowsInTableView(_ tableView: NSTableView) -> Int {
        return self.preferences.count
    }
    
    func tableView(_ tableView: NSTableView,
        objectValueForTableColumn tableColumn: NSTableColumn?,
        row: Int) -> AnyObject? {
           return self.preferences[row]
    }
    
}
