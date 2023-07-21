//
//  PlaceListView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

enum Services: String {
    case Escalator
    case Elevator
    case Staircase
}

enum ViewType: String {
    case ListView
    case MapView
}

struct PlaceListView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    @EnvironmentObject var locationManager: LocationDataManager
    @ObservedObject var watchvm = WatchViewModel.shared
    
    // Perubahan Abner
    @State var detourPreference: Services? = .Escalator
    @State var listView: ViewType = ViewType.ListView
    
    let category: Place.PlaceCategory
    
    var body: some View {
        VStack{
            HStack{
                Picker("List", selection: $listView){
                    Text("List").tag(ViewType.ListView)
                    Text("Map View").tag(ViewType.MapView)
                }
            }
            .pickerStyle(.segmented)
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            }
            .padding(.vertical, 10)
            switch listView {
            case .ListView:
                ScrollView {
                    ForEach(discoveryVM.getPlacesFiltered(by: category), id: \.self) { place in
                        NavigationLink(destination: PlaceDetailsView(isSameFloor: discoveryVM.isSameFloor, targetPlace: place, detourPreference: $detourPreference)
                            .onAppear{discoveryVM.appendDestination(to: place)
                                watchvm.sendPlaceToWatch(place)
                            }
                            .onDisappear{discoveryVM.clearDestination()}) {
                                PlaceListItem(place: place)
                            }
                    }
                }
                .onChange(of: detourPreference, perform: { way in
                    guard let detour = way else { return }
                    switch detour {
                    case Services.Staircase:
                        // get Place obj for staircase
                        print("added staircase coor to destinations")
                        break
                    case Services.Escalator:
                        // get Place obj for escalator
                        print("added escalator coor to destinations")
                        break
                    case Services.Elevator:
                        // get Place obj for lift
                        print("added lift coor to destinations")
                        break
                    }
                })
            case .MapView:
                VStack{
                    Text("Sabar ya belum jadi")
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 20)
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
        PlaceListView(category: .commercial)
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}


