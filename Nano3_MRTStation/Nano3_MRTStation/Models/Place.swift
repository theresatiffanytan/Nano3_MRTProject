//
//  Place.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let photo: String
    let category: PlaceCategory
    let location: Location
    var status: Status
//    var openHours: Time
    
    enum Status: String {
        case closed = "Closed", open = "Open", escalatorUp = "Up", escalatorDown = "Down"
    }
    
    enum PlaceCategory: String {
        case amenities = "Amenities"
        case eateries = "Eateries"
        case shops = "Shops"
        case exits = "Exit Gates"
        case counters = "Ticketing Counters"
        case information = "Information"
        case platforms = "Platforms"
        case parking = "Parking"
        case elevators = "Elevators"
        case escalators = "Escalators"
        case stairs = "Stairs"
        // Add more categories as needed
    }
}

extension Place {
    static let dummyPlace = [
        Place(
            name: "Restroom 1",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .amenities,
            location: Location(latitude: -6.196751, longitude: 106.822984, altitude: 0),
            status: .closed
        ),
        Place(
            name: "Eatery 1",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .eateries,
            location: Location(latitude: -6.196752, longitude: 106.822985, altitude: 0),
            status: .closed
        ),
        Place(
            name: "Shop 1",
            description: "Shop description",
            photo: "shop-photo",
            category: .shops,
            location: Location(latitude: -6.196753, longitude: 106.822986, altitude: 20),
            status: .closed
        ),
        Place(
            name: "Exit Gate 1",
            description: "Exit Gate description",
            photo: "exit-gate-photo",
            category: .exits,
            location: Location(latitude: -6.196754, longitude: 106.822987, altitude: 0),
            status: .closed
        ),
        Place(
            name: "Ticketing Counter 1",
            description: "Ticketing Counter description",
            photo: "ticketing-counter-photo",
            category: .counters,
            location: Location(latitude: -6.196755, longitude: 106.822988, altitude: 0),
            status: .closed
        ),
        Place(
            name: "Restroom 2",
            description: "Restroom description",
            photo: "restroom-photo",
            category: .amenities,
            location: Location(latitude: -6.123456, longitude: 106.789012, altitude: 0),
            status: .closed
        ),
        Place(
            name: "Eatery 2",
            description: "Eatery description",
            photo: "eatery-photo",
            category: .eateries,
            location: Location(latitude: -6.123457, longitude: 106.789013, altitude: 0),
            status: .closed
        ),
        // Add more places with different locations and categories as needed
    ]
}

