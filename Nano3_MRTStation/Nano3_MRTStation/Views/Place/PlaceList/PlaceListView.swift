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
    @ObservedObject var watchvm = WatchViewModel.shared
    @State var viewType: ViewType = ViewType.ListView
    let category: Place.PlaceCategory

    func setTabStyle() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        VStack{
            Picker("View Type", selection: $viewType){
                Text("List").tag(ViewType.ListView)
                Text("Map View").tag(ViewType.MapView)
            }
            .pickerStyle(.segmented)
            switch viewType {
            case .ListView:
                ScrollView {
                    ForEach(discoveryVM.getPlacesFiltered(by: category), id: \.self) { place in
                        NavigationLink(
                            destination: PlaceDetailsView(place: place)
                            .onAppear{
                                discoveryVM.appendDestination(to: place)
                                watchvm.sendPlaceToWatch(place)
                            }
                            .onDisappear{
                                discoveryVM.clearDestination()
                            }) {
                                PlaceListRow(place: place)
                                .padding(.vertical, 4)
                            }
                    }
                }
                // TODO: Refactor Detour Logic
//                .onChange(of: detourPreference, perform: { way in
//                    guard let detour = way else { return }
//                    switch detour {
//                    case Services.Staircase:
//                        // get Place obj for staircase
//                        print("added staircase coor to destinations")
//                        break
//                    case Services.Escalator:
//                        // get Place obj for escalator
//                        print("added escalator coor to destinations")
//                        break
//                    case Services.Elevator:
//                        // get Place obj for lift
//                        print("added lift coor to destinations")
//                        break
//                    }
//                })
            case .MapView:
                PlaceListMap()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .onAppear {
            setTabStyle()
            locationManager.validateLocationAuthorizationStatus()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
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


