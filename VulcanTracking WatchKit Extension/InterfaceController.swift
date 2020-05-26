//
//  InterfaceController.swift
//  VulcanTracking WatchKit Extension
//
//  Created by [developer]Hai on 5/26/20.
//  Copyright © 2020 [developer]Hai. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    let trackingService = TrackingService.shared

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
      
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func tappedSendEvent() {
        trackingService.sendEvent(eventName: "HomeScreen")
    }
}

