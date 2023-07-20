//
//  Nano3_MRTStationApp.swift
//  Nano3_MRTStation
//
//  Created by Theresa Tiffany on 15/07/23.
//

import SwiftUI

@main
struct Nano3_MRTStationApp: App {
    @StateObject private var locationManager: LocationDataManager
    @StateObject private var discoveryVM: DiscoveryViewModel
    
    init() {
        _locationManager = StateObject(wrappedValue: LocationDataManager())
        _discoveryVM = StateObject(wrappedValue: DiscoveryViewModel(locationManager: LocationDataManager()))
        discoveryVM.locationManager = locationManager
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(discoveryVM)
        }
    }
}

