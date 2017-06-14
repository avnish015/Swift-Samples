//
//  MenuBarIcon.swift
//  DontSleep
//
//  Created by avnish kumar on 04/02/16.
//  Copyright © 2016 avnish kumar. All rights reserved.
//

import Cocoa


let MenubarActiveIconName = "ActiveIcon"
let MenubarInactiveIconName = "InactiveIcon"


class MenuBarIcon: NSObject {
    
private lazy var __once: () = {
        
        if(self.hasCustomIcons())
        {
            let activeIcon = self.customActiveIcon()
            let inactiveIcon = self.customInactiveIcon()
            currentIcon = MenuBarIcon(activeIcon: activeIcon, inactiveIcon: inactiveIcon)
            
        }
        else
        {
        // There are no costum image files, fall back to the default icon.
            currentIcon = self.defaultIcon() as? MenuBarIcon;
        }
        }()
    
//An icon image representing the active state.
    var activeIcon:NSImage?
//An icon image representing the inactive state.
    var inactiveIcon:NSImage?
    
    var currentActiveIcon:NSImage?{
        set{
           self.willChangeValue(forKey: "activeIcon")
            if(newValue != nil)
            {
                self.activeIcon = newValue;
            }
            else
            {
                self.activeIcon = NSImage(named: MenubarActiveIconName)
            }
            self.didChangeValue(forKey: "activeIcon")
        }
        get{
            return self.activeIcon
        }
        
    }
    var currentInactiveIcon:NSImage?{
        
        set{
            self.willChangeValue(forKey: "inactiveIcon")
            if(newValue != nil)
            {
                self.inactiveIcon = newValue;
            }
            else
            {
                self.inactiveIcon = NSImage(named: MenubarInactiveIconName)
            }
            self.didChangeValue(forKey: "inactiveIcon")
        }
        get{
            return self.inactiveIcon
        }
        

    }
    
    
    /**
     *  Returns a menubar icon set for either the default icon
     *  or a set of custom icons from the application support
     *  directory.
     *
     *  This class method will always return the same MenuBarIcon
     *  instance during the lifetime of the app.
     */
    static func currentIcon()->MenuBarIcon
    {
        var currentIcon:MenuBarIcon?
        
        var onceToken:Int = 0
        
        _ = self.__once
        
        return currentIcon!

    }
    
    static func customActiveIcon()->NSImage
    {
        return self.customIconNamed(MenubarActiveIconName);
    }
    
    static func customInactiveIcon()->NSImage
    {
        return self.customIconNamed(MenubarInactiveIconName)
    }
    
    static func customIconNamed(_ name:String)->NSImage
    {
        let image = NSImage(contentsOf:URL(fileURLWithPath:name))
        
        
    image!.isTemplate = true;
        
        let retinaRep = NSImageRep.imageReps(withContentsOf: URL(fileURLWithPath:name))
    
    if((retinaRep) != nil)
    {
        image!.addRepresentation(retinaRep![0])
    }
    
    return image!
    }


    
    static func defaultIcon()->AnyObject
    {
        return MenuBarIcon()
    }
    
   init(activeIcon:NSImage?, inactiveIcon:NSImage?)
   {
        super.init();

        self.currentActiveIcon = activeIcon;
        self.currentInactiveIcon = inactiveIcon;
    }
    
    override convenience init()
    {
        self.init(activeIcon: nil,inactiveIcon:nil)
        
    }
    
    
    
    static func hasCustomIcons()->Bool
    {
       var hasAllImageFiles:Bool = true;
    
        if(!self.iconWithNameExistsAtPath(MenubarActiveIconName, isRetinaIcon:false))
        {
            hasAllImageFiles = false;
        }
        if(!self.iconWithNameExistsAtPath(MenubarActiveIconName, isRetinaIcon:true))
        {
            hasAllImageFiles = false;
        }
        if(!self.iconWithNameExistsAtPath(MenubarInactiveIconName,   isRetinaIcon:false))
        {
            hasAllImageFiles = false;
        }
        if(!self.iconWithNameExistsAtPath(MenubarInactiveIconName, isRetinaIcon:true))
        {
            hasAllImageFiles = false;
        }
    
        return hasAllImageFiles;
    }
    
    static func iconWithNameExistsAtPath(_ name:String, isRetinaIcon:Bool) -> Bool
    {
        let fileURL = self.iconFileURLWithName(name, isRetinaIcon:isRetinaIcon);
        return FileManager.default.fileExists(atPath: fileURL.path);
    }
    
    static func iconFileURLWithName(_ name:String, isRetinaIcon:Bool)-> URL
    {
        let suffix = isRetinaIcon ? "@2x" : ""
        let composedName =  String("\(name)\(suffix).png")
        
        return self.applicationSupportDirectoryURL().appendingPathComponent(composedName!, isDirectory: false)
    }
    
    static func applicationSupportDirectoryURL()->URL
    {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: FileManager.SearchPathDirectory.applicationSupportDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last
        //let appSupportURL = [fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask].lastObject;
        return appSupportURL!.appendingPathComponent("DontSleep");
    }
    
    


}
