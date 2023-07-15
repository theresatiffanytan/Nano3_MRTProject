//
//  PlaceListView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

struct PlaceListView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel

    var body: some View {
        List(discoveryVM.currentStation.places, id: \.id) { place in
            NavigationLink(
                destination: CompassView(targetPlace: place)) {
                    PlaceListRow(place: place)
                }
        }
        .navigationTitle(discoveryVM.currentStation.name)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
            .environmentObject(DiscoveryViewModel())
    }
}
