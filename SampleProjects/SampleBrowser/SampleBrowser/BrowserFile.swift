//
//  BrowserFile.swift
//  SampleBrowser
//
//  Created by avnish kumar on 27/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Foundation

class BrowserFile {
    
    let url:URL
    init(url:URL) {
        
        self.url = url
    }
    
    var children:[BrowserFile]? {
        
        get {
            let manager = FileManager.default
            do {
                    if try self.url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory! {
                
                        let childrenArray = try manager.contentsOfDirectory(atPath: self.url.path)
                        var childNodes = [BrowserFile]()
                        for child in childrenArray {
                            let path = self.url.path + "/\(child)"
                            let browserFile = BrowserFile(url: URL(fileURLWithPath: path))
                            childNodes.append(browserFile)
                        }
                        return childNodes
                    }
                }catch {
                    print(error)
                }
                return nil
        }
    }
    
    var displayName:String? {
        get {
            do {
                return try self.url.resourceValues(forKeys: [.localizedNameKey]).localizedName
            }catch {
                return nil
            }
        }
    }
    
    var isDirectory:Bool {
        get {
            do {
                return try self.url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory!
            }catch {
                return false
            }
        }
    }
}
