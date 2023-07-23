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
//    let targetplace : Place
    let destionations: [Place]
    
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
