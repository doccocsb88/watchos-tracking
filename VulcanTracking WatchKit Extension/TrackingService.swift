//
//  TrackingService.swift
//  VulcanTracking WatchKit Extension
//
//  Created by [developer]Hai on 5/26/20.
//  Copyright © 2020 [developer]Hai. All rights reserved.
//

import Foundation

class TrackingService {
    static let shared = TrackingService()
    var events: [Event] = []
    var locationParams: [String: Any] = [:]
    init() {
        getLocationInfo()
    }
    
    private func getLocationInfo() {
        guard let url = URL(string: "http://ip-api.com/json") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    self.locationParams = json
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func sendEvent(eventName: String) {
        let event = Event(eventName: eventName, parameters: locationParams)
        
        events.append(event)
        guard let url = URL(string: "http://localhost:3000/events/") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parameters: [String: Any] = event.dict
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil, let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    if let status = json["status"] as? Bool, status {
                        self.events.removeAll(where: {$0.eventName == eventName})
                    }
                    
                    print("numberOfEvents \(self.events.count)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}
