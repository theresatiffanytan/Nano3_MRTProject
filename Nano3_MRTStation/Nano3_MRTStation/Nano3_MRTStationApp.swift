//
//  Nano3_MRTStationApp.swift
//  Nano3_MRTStation
//
//  Created by Theresa Tiffany on 15/07/23.
//

import SwiftUI
import FirebaseCore

@main
struct Nano3_MRTStationApp: App {
    //MARK: - Firebase Delegate Obj
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   
    @StateObject private var locationManager: LocationDataManager
    @StateObject private var discoveryVM: DiscoveryViewModel
//    @StateObject private var firebaseVM: FirebaseViewModel
    
    init() {
        _locationManager = StateObject(wrappedValue: LocationDataManager())
        _discoveryVM = StateObject(wrappedValue: DiscoveryViewModel(locationManager: LocationDataManager()))
//        _firebaseVM = StateObject(wrappedValue: FirebaseViewModel())
        
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

//MARK: - Firebase Delegate Class
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

