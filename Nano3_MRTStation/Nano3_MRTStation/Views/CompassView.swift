//
//  CompassView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI

struct CompassView: View {
    let targetPlace: Place
    @EnvironmentObject var locationManager: LocationDataManager

    var body: some View {
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
        .onAppear {
            locationManager.validateLocationAuthorizationStatus()
            locationManager.startHeadingUpdates()
            locationManager.startMonitoringRegion(center: targetPlace.location.toCLLocation(), identifier: targetPlace.name)
        }
        .onDisappear {
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
    }

    var content: some View {
        VStack {
            Text(locationManager.headingDesc)
                .font(.title)
                .padding()
            Image(systemName: "location.north.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .rotationEffect(.degrees(locationManager.heading))
            Text("Current Location: \(locationManager.currentLocation.description)")
                .font(.body)
                .padding()
            Text("Target Location: \(locationManager.targetLocation.description)")
                .font(.body)
                .padding()
            Text(locationManager.distanceDesc)
                .font(.body)
                .padding()
        }
        .multilineTextAlignment(.center)

    }
}


struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView(targetPlace: Place.dummyPlace[0])
            .environmentObject(LocationDataManager())
    }
}
