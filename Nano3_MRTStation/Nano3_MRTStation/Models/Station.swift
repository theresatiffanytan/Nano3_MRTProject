//
//  Station.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Station: Identifiable, Codable, Hashable, CustomStringConvertible {
    @DocumentID var id: String?
    let name: String
    let location: Location
    var places: [Place]

    var description: String {
        return "Station: \(name), Location: \(location), Places: \(places)"
    }
}

//extension Station {
//    static let dummyStations: [Station] = [
//        Station(
//            name: "Bundaran HI",
//            location: Location(latitude: -6.196751, longitude: 106.822984, altitude: 0),
//            places: [
//                Place.dummyPlace[0],
//                Place.dummyPlace[1],
//                Place.dummyPlace[2],
//            ]
//        ),
//        Station(
//            name: "Blok M",
//            location: Location(latitude: -6.196751, longitude: 106.822984, altitude: 0),
//            places: [
//                Place.dummyPlace[3],
//                Place.dummyPlace[4],
//                Place.dummyPlace[5],
//            ]
//        ),
//        // Add more stations as needed
//    ]
//}

