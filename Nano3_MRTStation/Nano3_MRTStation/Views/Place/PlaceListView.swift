//
//  PlaceListView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI
import WatchConnectivity

struct PlaceListView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    @ObservedObject var watchvm = WatchViewModel.shared
    @State var isShowing = false
    
    
    
    
    var body: some View {
        List(discoveryVM.currentStation.places, id: \.id) { place in

            Button{
                isShowing = true
//                watchvm.sendLocationToWatch(name: place.name, altitude: place.location.latitude)
                watchvm.sendPlaceToWatch(place)
            }label: {
                VStack(alignment: .leading){
                    Text(place.name)
                    Text(place.description)

                }
            }
            .sheet(isPresented: $isShowing) {
                CompassView(isShowing: $isShowing, targetPlace: place)
            }

        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
            .environmentObject(DiscoveryViewModel())
    }
}
