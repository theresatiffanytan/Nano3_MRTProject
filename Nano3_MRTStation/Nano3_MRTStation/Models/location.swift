//
//  location.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation
import CoreLocation

struct Location: Hashable, Codable {
    let latitude: Double
    let longitude: Double
    let altitude: Double
}

extension Location {
    var floorLevel: Int {
        let floorThresholds: [Double] = [0.0, 10.0, 20.0, 30.0] // Dummy thresholds for floor levels
        //Threshold elevation ke lantai berikut: 14.28
//        Elevation lt 1: 14.33
//        Elevation lt 2: 14.25
        // 1/33 = 0.03 -> lantai 1
        // 1/25 = 0.04 -> lantai 2
        let defaultFloorLevel = 1
        for (index, threshold) in floorThresholds.enumerated() {
            if altitude < threshold {
                return index + 1
            }
        }
        return defaultFloorLevel
    }
    
    func formattedFloorLevel() -> String {
        if floorLevel == 1 {
            return String(floorLevel) + "st Floor"
        }else if floorLevel == 2{
            return String(floorLevel) + "nd Floor"
        }else {
            return String(floorLevel) + "rd Floor"
        }
    }

    func toCLLocation() -> CLLocation {
        return CLLocation(
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            altitude: altitude,
            horizontalAccuracy: kCLLocationAccuracyBest,
            verticalAccuracy: kCLLocationAccuracyBest,
            timestamp: Date()
        )
    }
}

