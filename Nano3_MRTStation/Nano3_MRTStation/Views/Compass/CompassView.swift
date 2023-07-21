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
//        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
//        }
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
                .padding(.top, 16)
            Spacer()
            Text("BLalbalblalbalbl\nalbalblalblablabal")
                .font(.body)
                .lineLimit(2, reservesSpace: true)
                .padding(.horizontal)
            Spacer()
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
            Spacer()
            Text("\(locationManager.distance.distanceDesc) away")
                .font(.body)
            Text(locationManager.headingDesc)
                .font(.title)
                .bold()
                .lineLimit(3, reservesSpace: true)
                .padding(.top, 2)
                .padding(.horizontal)
            Spacer()
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
