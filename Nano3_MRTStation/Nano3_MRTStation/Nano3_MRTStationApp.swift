//
//  Nano3_MRTStationApp.swift
//  Nano3_MRTStation
//
//  Created by Theresa Tiffany on 15/07/23.
//
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Nano3_MRTStationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var locationManager = LocationDataManager()
    @StateObject private var discoveryVM = DiscoveryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(discoveryVM)
                .environmentObject(locationManager)
        }
    }
}


