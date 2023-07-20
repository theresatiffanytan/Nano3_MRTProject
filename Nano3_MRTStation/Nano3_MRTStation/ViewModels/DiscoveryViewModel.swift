//
//  DiscoveryViewModel.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation
import CoreLocation

class DiscoveryViewModel: ObservableObject {
    @Published var currentStation = Station.dummyStations[0]
    @Published var destinations: [Place] = []
    @Published var isSameFloor: Bool = false
    @Published var detourPlace: Place? = nil
    var locationManager: LocationDataManager
    
    init(locationManager: LocationDataManager) {
        self.locationManager = locationManager
    }
    
    //    @Published var
    //    @Published var currentLevel: Place =
    // VAR level sekarang, tipe data place
    
    
    // FUNC floor level sama gk sama destinasi
    // Location Manager, get curr alt
    // VAR destination: [place] = [esc, finalDest]
    
    func appendDestination(to targetPlace: Place) -> () {
        destinations.append(targetPlace)
        updateIsSameFloor()
    }
    
    func clearDestination() -> () {
        destinations = []
    }
    
    func appendDetour() -> () {
        guard let detour = detourPlace, !isSameFloor else { return }
        destinations.insert(detour, at: 0)
    }
    
    func updateIsSameFloor() -> () {
        isSameFloor = locationManager.currentLocation.toLocation().floorLevel == destinations.first?.location.floorLevel
    }
}
