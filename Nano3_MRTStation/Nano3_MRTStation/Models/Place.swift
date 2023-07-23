//
//  Place.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation
import SwiftUI

struct Place: Hashable, Codable {
    let name: String
    let description: String
    let photo: String
    let category: PlaceCategory
    let status: PlaceStatus
    let location: Location
    
    var distance: Double = 0
    var progress: PlaceProgress = .pending
    

    enum PlaceCategory: String, Codable, CaseIterable {
        case accessibility = "Accessibility"
        case commercial = "Commercial Area"
        case restroom = "Restrooms"
        case prayer = "Prayer Rooms"
        case firstAid = "First Aid"
        case nursing = "Nursing Room"
        case ticketing = "Ticketing"
        case service = "Services"
        case exit = "Exit Gates"
        case disability = "Disability Facility"

        var icon: String {
            switch self {
            case .accessibility:
                return "escalator 1"
            case .commercial:
                return "commercial"
            case .restroom:
                return "restroom"
            case .prayer:
                return "prayer"
            case .firstAid:
                return "firstaid"
            case .nursing:
                return "nursing"
            case .ticketing:
                return "ticketing"
            case .service:
                return "service"
            case .disability:
                return "disability"
            case .exit:
                return "disability"
            }
        }

        enum AccessibilityType: String {
            case escalator = "escalator"
            case lift = "lift"
            case stairs = "stairs"
        }
    }
    
    
    enum PlaceStatus: String, Codable, CaseIterable {
        case open = "Open"
        case closed = "Closed"
        case up = "Up"
        case down = "Down"

        var color: Color {
            switch self {
            case .open:
                return .green
            case .closed:
                return .red
            case .up, .down:
                return .accentColor
            }
        }
    }

    enum PlaceProgress: CaseIterable {
        case completed
        case pending
        case ongoing
    }
    
    // Ignore "distance" & "progress" properties from Codable
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case photo
        case category
        case status
        case location
        
    }
}

extension Place {
    
    func getAccessibilityType() -> Place.PlaceCategory.AccessibilityType?{
        let name = self.name.lowercased()
        if name.contains("escalator") {
            return .escalator
        }else if name.contains("lift") {
            return .lift
        }else if name.contains("stair") {
            return .stairs
        }else {
            return nil
        }
    }
    
    static let dummyPlace = [
        Place(
            name: "Apple Campus",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .commercial,
            status: .open,
            location: Location(latitude: 37.33182000, longitude: -122.03118000, altitude: 20)
        ),
        Place(
            name: "Muse Salon",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .commercial,
            status: .open,
            location: Location(latitude: 37.33162000, longitude: -122.03302000, altitude: 0)
        ),
        Place(
            name: "Shop 1",
            description: "Shop description",
            photo: "shop-photo",
            category: .commercial,
            status: .open,
            location: Location(latitude: -6.196753, longitude: 106.822986, altitude: 0)
        ),
        Place(
            name: "Exit Gate 1",
            description: "Exit Gate description",
            photo: "exit-gate-photo",
            category: .service,
            status: .open,
            location: Location(latitude: -6.196754, longitude: 106.822987, altitude: 0)
        ),
        Place(
            name: "Ticketing Counter 1",
            description: "Ticketing Counter description",
            photo: "ticketing-counter-photo",
            category: .ticketing,
            status: .open,
            location: Location(latitude: -6.196755, longitude: 106.822988, altitude: 0)
        ),
        Place(
            name: "Restroom 2",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .restroom,
            status: .open,
            location: Location(latitude: -6.123456, longitude: 106.789012, altitude: 0)
        ),
        Place(
            name: "Eatery 2",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .restroom,
            status: .open,
            location: Location(latitude: -6.123457, longitude: 106.789013, altitude: 0)
        ),
    ]
}




