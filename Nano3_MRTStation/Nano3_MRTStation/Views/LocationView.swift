//
//  LocationStateView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI

struct LocationView: View {
    @EnvironmentObject var locationManager: LocationDataManager

    var body: some View {
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
        .onAppear {
            locationManager.validateLocationAuthorizationStatus()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
    }

    var content: some View {
        VStack {
            Text("Latitude: \(locationManager.currentLocation.coordinate.latitude)")
            Text("Longitude: \(locationManager.currentLocation.coordinate.longitude)")
            Text("Horizontal Accuracy: \(locationManager.currentLocation.horizontalAccuracy)")
            Text("Altitude: \(locationManager.currentLocation.altitude)")
            Text("Vertical Accuracy: \(locationManager.currentLocation.verticalAccuracy)")
        }
    }
}

struct LocationStateView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationDataManager())
    }
}
