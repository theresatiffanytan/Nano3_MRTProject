//
//  PlaceListView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    @EnvironmentObject var locationManager: LocationDataManager
    let category: Place.PlaceCategory

    var body: some View {
        List(discoveryVM.getPlacesFiltered(by: category), id: \.self) { place in
            NavigationLink(
                destination: CompassView(targetPlace: place)) {
                    PlaceListItem(place: place)
                }
        }
        .onAppear {
            locationManager.validateLocationAuthorizationStatus()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(category: .shops)
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}
