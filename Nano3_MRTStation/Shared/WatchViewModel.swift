//
//  WatchViewModel.swift
//  Nano3_MRTStation
//
//  Created by Adriel Bernard Rusli on 16/07/23.
//

import Foundation
import WatchConnectivity
import CoreLocation
import SwiftUI
//import WatchKit


final class WatchViewModel: NSObject, ObservableObject {
    static let shared = WatchViewModel()
    @Published var receivedPlace: Place? = nil
    
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
            "id": place.id.uuidString,
            "name": place.name,
            "description": place.description,
            "photo": place.photo,
            "category": place.category.rawValue,
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
        if let idString = message["id"] as? String,
           let name = message["name"] as? String,
           let description = message["description"] as? String,
           let photo = message["photo"] as? String,
           let categoryString = message["category"] as? String,
           let category = Place.PlaceCategory(rawValue: categoryString),
           let locationData = message["location"] as? [String: Any],
           let latitude = locationData["latitude"] as? Double,
           let altitude = locationData["altitude"] as? Double,
           let longitude = locationData["longitude"] as? Double {
            
            DispatchQueue.main.async {
                let location = Location(latitude: latitude, longitude: longitude, altitude: altitude)
                let place = Place(name: name, description: description, photo: photo, category: category, location: location)
                self.receivedPlace = place
                
                
            }
            
            let device = WKInterfaceDevice.current()
            device.play(.success)
        }
#endif
    }
    
    
}
