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
    var isCompleted: Bool = false
    
    enum PlaceCategory: String, Codable, CaseIterable {
        case amenities = "Amenities"
        case eateries = "Eateries"
        case escalator = "Escalator, lift"
        case commercial = "Commercial area"
        case toilet = "Toilet"
        case mushalla = "Mushalla"
        case firstaid = "First aid"
        case nursing = "Nursing room"
        case ticket = "Ticket machine"
        case service = "Service office"
        case disability = "Disability facilities"
        case accessibility = "Accessibility"
        
        var icon: String {
            switch self {
            case .amenities:
                return "amenities-icon"
            case .eateries:
                return "eateries-icon"
            case .escalator:
                return "escalator"
            case .commercial:
                return "coffee-cup 1"
            case .toilet:
                return "toilet 1"
            case .mushalla:
                return "mosque 1"
            case .firstaid:
                return "first-aid-kit 1"
            case .nursing:
                return "pacifier-2 1"
            case .ticket:
                return "atm-card 1"
            case .service:
                return "office 1"
            case .disability:
                return "wheelchair 1"
            case .accessibility:
                return "escalator"
            }
        }

        enum AccessibilityType: String {
            case escalator = "Escalator"
            case lift = "Lift"
            case stairs = "Stairs"
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
    
    // Ignore "distance" & "isCompleted" properties from Codable
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
    static let dummyPlace = [
        Place(
            name: "Restroom 1",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .amenities,
            status: .open,
            location: Location(latitude: -6.196751, longitude: 106.822984, altitude: 0)
        ),
        Place(
            name: "Eatery 1",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .eateries,
            status: .open,
            location: Location(latitude: -6.196752, longitude: 106.822985, altitude: 0)
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
            category: .ticket,
            status: .open,
            location: Location(latitude: -6.196755, longitude: 106.822988, altitude: 0)
        ),
        Place(
            name: "Restroom 2",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .amenities,
            status: .open,
            location: Location(latitude: -6.123456, longitude: 106.789012, altitude: 0)
        ),
        Place(
            name: "Eatery 2",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .eateries,
            status: .open,
            location: Location(latitude: -6.123457, longitude: 106.789013, altitude: 0)
        ),
    ]
}
