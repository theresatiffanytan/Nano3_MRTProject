//
//  WatchCompassView.swift
//  Nano3-Watch Watch App
//
//  Created by Adriel Bernard Rusli on 17/07/23.
//

import SwiftUI
import WatchConnectivity

struct WatchCompassView: View {
    @ObservedObject var WatchVM = WatchViewModel.shared
    @Binding var isShowing : Bool
    @EnvironmentObject var locationManager: LocationDataManager
    let targetplace : Place
    
    var body: some View {
        
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
        .onAppear {
            locationManager.validateLocationAuthorizationStatus()
            locationManager.startHeadingUpdates()
            
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
        }
    }
    
    var content: some View {
        VStack {
          
            Image(systemName: "location.north.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .rotationEffect(.degrees(locationManager.heading))
            Text(locationManager.headingDesc)
                .font(.system(size: 17))
                .padding()
            Text(locationManager.distance.distanceDesc)
                .font(.system(size: 10))
        }
        .multilineTextAlignment(.center)
        
    }
}


