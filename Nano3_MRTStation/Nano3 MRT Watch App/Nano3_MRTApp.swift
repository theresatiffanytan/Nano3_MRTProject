//
//  Nano3_MRTApp.swift
//  Nano3 MRT Watch App
//
//  Created by Adriel Bernard Rusli on 20/07/23.
//

import SwiftUI

@main
struct Nano3_MRT_Watch_AppApp: App {
    
    @StateObject private var watchViewModel = WatchViewModel.shared
    @StateObject private var locationManager = LocationDataManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(watchViewModel)
                .environmentObject(locationManager)
        }
    }
}
