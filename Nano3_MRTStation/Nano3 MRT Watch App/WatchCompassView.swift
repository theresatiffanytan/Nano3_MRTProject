//
//  WatchCompassView.swift
//  Nano3-Watch Watch App
//
//  Created by Adriel Bernard Rusli on 17/07/23.
//

import SwiftUI
import WatchConnectivity

struct WatchCompassView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var WatchVM = WatchViewModel.shared
    @Binding var isShowing : Bool
    @EnvironmentObject var locationManager: LocationDataManager
//    let targetplace : Place
    let destinations: [Place]
    
    var body: some View {
        
        LocationStateView(authorizationStatus: locationManager.authorizationStatus) {
            content
        }
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
            
            Spacer()
                Text(locationManager.getTripActionDesc())
                    .font(.system(size: 14))
                    .frame(maxWidth: 140)
            Spacer()
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
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
                        .frame(width: 20, height: 20)
                        .rotationEffect(.degrees(locationManager.heading))
                }
            Spacer()
            Text("\(locationManager.distance.distanceDesc) away")
                .font(.system(size: 12))
            Text("\(locationManager.headingDesc)")
                .font(.system(size: 14))
            
        }
        .multilineTextAlignment(.center)
        .onDisappear{
            WatchVM.receivedDestionation.removeAll()
        }
       
        
    }
}

//struct WatchCompassView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchCompassView(isShowing: .constant(true), targetplace: Place.dummyPlace[0])
//            .environmentObject(LocationDataManager())
//    }
//}
