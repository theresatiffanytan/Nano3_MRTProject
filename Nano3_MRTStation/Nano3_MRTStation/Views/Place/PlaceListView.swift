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
        List(discoveryVM.currentStation.places) { place in
            NavigationLink(destination: DetailView(targetPlace: place)
                .onAppear{discoveryVM.appendDestination(to: place)}
                .onDisappear{discoveryVM.clearDestination()}) {
                    PlaceListRow(place: place)
                }
        }
        .navigationTitle(discoveryVM.currentStation.name)
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PlaceListView()
                .environmentObject(DiscoveryViewModel(locationManager: LocationDataManager()))
        }
    }
}

struct DetailView: View {
    let targetPlace: Place
    var body: some View {
        Text("")
    }
}
