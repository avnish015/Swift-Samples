//
//  CustomView.swift
//  SampleDragAndDrop
//
//  Created by avnish kumar on 20/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import Cocoa

class CustomView: NSImageView {

    override func awakeFromNib() {
        
        register(forDraggedTypes: [NSPasteboardTypePDF,NSPasteboardTypePNG, NSPasteboardTypeString])
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

    }
    
    override func draggingEnded(_ sender: NSDraggingInfo?) {
        
        
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        
        
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        return [.copy, .delete]
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        
        return [.copy, .delete]
    }
    
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        let pasteBoard = sender.draggingPasteboard()
        if let fileUrls = pasteBoard.readObjects(forClasses: [NSURL.self], options: [NSPasteboardURLReadingContentsConformToTypesKey:NSImage.imageTypes()]) as? [URL] {
            
            for url in fileUrls {
                
                let image = NSImage(byReferencing: url)
                let center = sender.draggingLocation()
                let sizeOfImage = image.size
                let subView = NSImageView(frame: NSRect(x: (center.x) - sizeOfImage.width/2, y: (center.y) - sizeOfImage.height/2, width: sizeOfImage.width, height: sizeOfImage.height))
                self.addSubview(subView)
            }
            
            
        }

        return true
    }

}
