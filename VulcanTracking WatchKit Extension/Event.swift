//
//  Event.swift
//  VulcanTracking WatchKit Extension
//
//  Created by [developer]Hai on 5/26/20.
//  Copyright © 2020 [developer]Hai. All rights reserved.
//

import Foundation
class Event {
    let eventName: String
    var parameters: [String: Any]
    init(eventName: String, parameters: [String: Any] = [: ]) {
        self.eventName = eventName
        self.parameters = parameters
    }
    
    var dict: [String: Any] {
        let createdDate = Date().timeIntervalSince1970
        return [ "eventName": self.eventName, "created_date": createdDate ].merging(self.parameters) { $1 }
    }
    
}
