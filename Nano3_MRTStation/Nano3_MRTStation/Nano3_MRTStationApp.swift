//
//  Nano3_MRTStationApp.swift
//  Nano3_MRTStation
//
//  Created by Theresa Tiffany on 15/07/23.
//

import SwiftUI

@main
struct CLPlaygroundApp: App {
    @StateObject private var locationManager = LocationDataManager()
    @StateObject private var discoveryVM = DiscoveryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(discoveryVM)
        }
    }
}
