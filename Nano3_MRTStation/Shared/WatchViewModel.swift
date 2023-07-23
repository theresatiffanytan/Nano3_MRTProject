//
//  WatchViewModel.swift
//  Nano3_MRTStation
//
//  Created by Adriel Bernard Rusli on 20/07/23.
//

import Foundation
import WatchConnectivity
import CoreLocation
import SwiftUI

final class WatchViewModel: NSObject, ObservableObject {
    static let shared = WatchViewModel()
    //    @Published var receivedPlace: Place? = nil
    @Published var receivedPlace: Place? = nil
    @Published var receivedDestionation : [Place] = []
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}

extension WatchViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle session activation completion if needed
    }
    
#if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session becoming inactive if needed
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Handle session deactivation if needed
    }
#endif
    
    func sendPlaceToWatch(_ place: Place) {
        let placeData: [String: Any] = [
            "name": place.name,
            "description": place.description,
            "photo": place.photo,
            "category": place.category.rawValue,
            "status" : place.status.rawValue,
            "distance" : place.distance,
            "location": [
                "latitude": place.location.latitude,
                "longitude": place.location.longitude,
                "altitude": place.location.altitude
            ]
        ]
        
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(placeData, replyHandler: nil) { error in
                print("Error sending data: \(error)")
            }
        } else {
            print("Connection not reachable")
        }
    }
    
    func sendDestionationToWatch(_ destination: [Place]){
        for place in destination {
            let placeData: [String: Any] = [
                "name": place.name,
                "description": place.description,
                "photo": place.photo,
                "category": place.category.rawValue,
                "status" : place.status.rawValue,
                "distance" : place.distance,
                "location": [
                    "latitude": place.location.latitude,
                    "longitude": place.location.longitude,
                    "altitude": place.location.altitude
                ]
            ]
            
            if WCSession.default.isReachable{
                WCSession.default.sendMessage(placeData, replyHandler: nil){
                    error in print("error sending data : \(error)")
                    
                }
            }else{
                print("Connection not reachable")
            }
            
        }
        
        receivedDestionation.removeAll()
        
        
        
    }
    
    func sendMessage() {
        if WCSession.default.isReachable {
            let message = ["action": "callToAction"]
            WCSession.default.sendMessage(message, replyHandler: nil)
        } else {
            print("Connection bad")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
#if os(watchOS)
        print("Received message on Apple Watch:")
        for (key, value) in message {
            print("\(key): \(value)")
        }
        if let name = message["name"] as? String,
           let description = message["description"] as? String,
           let photo = message["photo"] as? String,
           let categoryString = message["category"] as? String,
           let statusString = message["status"] as? String,
           let category = Place.PlaceCategory(rawValue: categoryString),
           let status = Place.PlaceStatus(rawValue: statusString),
           let distance = message["distance"] as? Double,
           let locationData = message["location"] as? [String: Any],
           let latitude = locationData["latitude"] as? Double,
           let altitude = locationData["altitude"] as? Double,
           let longitude = locationData["longitude"] as? Double {
            
            DispatchQueue.main.async {
               
                let location = Location(latitude: latitude, longitude: longitude, altitude: altitude)
                //                let place = Place(name: name, description: description, photo: photo, category: category, location: location)
                let place = Place(name: name, description: description, photo: photo, category: category, status: status, location: location , distance: distance)
                
                //                self.receivedPlace = place
                self.receivedDestionation.append(place)
                
                
                
            }
            
            let device = WKInterfaceDevice.current()
            device.play(.success)
        }
#endif
    }
    
    
}
