//
//  CompassView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI

struct CompassView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var locationManager: LocationDataManager
    let destinations: [Place]

    var body: some View {
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
        .padding()
        .alert("You've arrived to \(locationManager.targetPlace?.name ?? "No Location")", isPresented: $locationManager.didArrived) {
            Button("OK", role: .cancel) {
                locationManager.updateTrip()
            }
        }
        .onChange(of: locationManager.tripFinished) { newValue in
            if newValue {
                dismiss()
            }
        }
        .onAppear {
            locationManager.destinations = destinations
            locationManager.startTrip()
        }
        .onDisappear {
            locationManager.stopTrip()
        }
    }

    var content: some View {
        VStack {
            StepperProgressBar(destinations: locationManager.destinations)
                .padding(.top, 16)
            Spacer()
            Text(locationManager.getTripActionDesc())
                .font(.body)
                .lineLimit(2, reservesSpace: true)
                .padding()
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
            Text("\(locationManager.headingDesc)")
                .font(.title2)
                .bold()
                .padding(.top, 1)
            Spacer()
        }
        .multilineTextAlignment(.center)
    }
}


struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView(
            destinations: [Place.dummyPlace[0], Place.dummyPlace[1]])
        .environmentObject(LocationDataManager())
    }
}
