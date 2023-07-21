//
//  CompassView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI

struct CompassView: View {
    @EnvironmentObject var locationManager: LocationDataManager
    let targetPlace: Place

    var body: some View {
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
        .padding()
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
            StepperProgressBar(destinations: [Place.dummyPlace[1], Place.dummyPlace[2]])
            Text("BLalbalblalbalbl\nalbalblalblablabal")
                .font(.body)
                .padding(.horizontal)
                .padding(.top, 48)
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(locationManager.heading))
                .overlay(alignment: .top) {
                    Image("radial")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .overlay {
                    Image(systemName: "location.north.fill")
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 36, height: 36)
                        .rotationEffect(.degrees(locationManager.heading))
                }
                .padding(.top, 48)
            Text("\(locationManager.distance.distanceDesc) away")
                .font(.body)
                .padding(.top, 36)
            Text(locationManager.headingDesc)
                .font(.title)
                .bold()
                .padding(.top, 2)
                .padding(.horizontal)
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}


struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView(targetPlace: Place.dummyPlace[0])
            .environmentObject(LocationDataManager())
    }
}
