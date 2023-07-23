//
//  PlaceListView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

enum ViewType: String { case ListView, MapView}

struct PlaceListView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    @EnvironmentObject var locationManager: LocationDataManager
    @State private var viewType: ViewType = ViewType.ListView
    @State private var places: [Place] = []
    @State private var accessiblityPlaces: [Place] = []
    let category: Place.PlaceCategory
    
    func setTabStyle() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "AccentColor")
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack{
            Picker("View Type", selection: $viewType){
                Text("List").tag(ViewType.ListView).tag("")
                Text("Map View").tag(ViewType.MapView).tag("")
            }
            .pickerStyle(.segmented)
            switch viewType {
            case .ListView:
                ScrollView {
                    ForEach(places, id: \.self) { place in
                        NavigationLink(
                            destination: PlaceDetailsView(places: accessiblityPlaces, targetPlace: place)
                        ) {
                            PlaceListRow(place: place)
                                .padding(.vertical, 4)
                        }
                    }
                }
            case .MapView:
                PlaceListMap()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            setTabStyle()
            places = discoveryVM.getPlacesFiltered(by: category, from: locationManager.currentLocation)
            accessiblityPlaces = discoveryVM.getPlacesFiltered(by: .accessibility, from: locationManager.currentLocation)
        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(category: .commercial)
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}


