//
//  NSApplication+LoginItem.swift
//  DontSleep
//
//  Created by avnish kumar on 12/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa

extension NSApplication
{
    var startAtLogin:Bool{
        
        set{
            
            willChangeValueForKey("startAtLogin")
            if(newValue)
            {
                toggleLaunchAtStartup()
            }
            else{
                
                removeFromLoginItems()
            }
            didChangeValueForKey("startAtLogin")
        }
        get{
            
            return self.hasLoginItem()
        }
    }
    
 func hasLoginItem()->Bool
{
    var result = false
    let loginItem:LSSharedFileListItemRef? = retainedLoginItem().existingReference
    if(loginItem != nil)
    {
        result = true
        
    }
    
    return result;
}




func retainedLoginItem() -> (existingReference: LSSharedFileListItemRef?, lastReference: LSSharedFileListItemRef?) {
    
    if let appUrl : NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileListRef?
        if loginItemsRef != nil {
            let loginItems: NSArray = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
            if(loginItems.count > 0)
            {
                let lastItemRef: LSSharedFileListItemRef = loginItems.lastObject as! LSSharedFileListItemRef
                for var i = 0; i < loginItems.count; ++i {
                    let currentItemRef: LSSharedFileListItemRef = loginItems.objectAtIndex(i) as! LSSharedFileListItemRef
                    if let itemURL = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, nil) {
                        if (itemURL.takeRetainedValue() as NSURL).isEqual(appUrl) {
                            return (currentItemRef, lastItemRef)
                        }
                    }
                }
                
                //The application was not found in the startup list
                return (nil, lastItemRef)
            } else {
                let addatstart: LSSharedFileListItemRef = kLSSharedFileListItemBeforeFirst.takeRetainedValue()
                return(nil,addatstart)
            }
        }
    }
    return (nil, nil)
}

func toggleLaunchAtStartup() {
    let itemReferences = retainedLoginItem()
    let shouldBeToggled = (itemReferences.existingReference == nil)
    if let loginItemsRef = LSSharedFileListCreate( nil, kLSSharedFileListSessionLoginItems.takeRetainedValue(), nil).takeRetainedValue() as LSSharedFileListRef? {
        if shouldBeToggled {
            if let appUrl : CFURLRef = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
                LSSharedFileListInsertItemURL(loginItemsRef, itemReferences.lastReference, nil, nil, appUrl, nil, nil)
            }
        } else {
            if let itemRef = itemReferences.existingReference {
                LSSharedFileListItemRemove(loginItemsRef,itemRef);
            }
        }
    }
}

func removeFromLoginItems()
{
    let loginItem = retainedLoginItem().existingReference
    
    
    if(loginItem != nil)
    {
        let loginItemsFileList = LSSharedFileListCreate(kCFAllocatorDefault,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil)
        
        LSSharedFileListItemRemove(loginItemsFileList.takeRetainedValue(), loginItem)
    }
    
    
    
    }
}


    



