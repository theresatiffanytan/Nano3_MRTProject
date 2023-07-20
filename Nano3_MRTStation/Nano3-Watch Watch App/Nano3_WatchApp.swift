//
//  Nano3_WatchApp.swift
//  Nano3-Watch Watch App
//
//  Created by Adriel Bernard Rusli on 16/07/23.
//

import SwiftUI

@main
struct Nano3_Watch_Watch_AppApp: App {
    @StateObject private var watchViewModel = WatchViewModel.shared
    @StateObject private var locationManager = LocationDataManager()

    var body: some Scene {
        WindowGroup {
            WactchContentView()
                .environmentObject(watchViewModel)
                .environmentObject(locationManager)

            
        }
    }
}
