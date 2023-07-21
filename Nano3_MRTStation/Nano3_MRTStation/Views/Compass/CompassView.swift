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
//        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
//        }
        .onAppear {
            locationManager.startHeadingUpdates()
            locationManager.startMonitoringRegion(center: targetPlace.location.toCLLocation(), identifier: targetPlace.name)
        }
        .onDisappear {
            locationManager.stopUpdatingHeading()
        }
    }

    var content: some View {
        VStack {
            StepperProgressBar(currentStep: 2, totalSteps: 4)
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
            Text(locationManager.distance.distanceDesc)
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
