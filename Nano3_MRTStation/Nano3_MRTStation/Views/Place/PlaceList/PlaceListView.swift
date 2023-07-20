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
    
    // Perubahan Abner
    @State var detourPreference: Services? = nil
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
                        NavigationLink(destination: DetailView(isSameFloor: discoveryVM.isSameFloor, targetPlace: place, detourPreference: $detourPreference)
                            .onAppear{discoveryVM.appendDestination(to: place)}
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
        PlaceListView(category: .shops)
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}


struct DetailView: View {
    @State var isPressed = false
    let alertTitle: String = "A Short Alert Title"
    let isSameFloor: Bool
    let targetPlace: Place
    @Binding var detourPreference: Services?
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(targetPlace.category.rawValue)
                        .font(.system(size: 14))
                        .foregroundColor(Color("TitleColor"))
                    Text(targetPlace.name)
                        .font(.system(size: 22, weight: .bold))
                }
                Spacer()
            }
            .padding(.vertical,10)
            
            HStack{
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Location")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text(targetPlace.location.formattedFloorLevel())
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.leading, 8)
                }
                Spacer()
                HStack{
                    Image(systemName: "location")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Distance")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text("\(targetPlace.location.getDistance()) m")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.leading, 8)
                }
                Spacer()
                HStack{
                    Image(systemName: "info.circle")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Status")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text(targetPlace.status.rawValue)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 8)
                }
            }
            .padding(.bottom, 15)
            .padding(.leading, 10)
            
            Image("indomaret")
                .frame(height: 202)
                .cornerRadius(8)
            
            HStack {
                Text("Details")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
            }
            .padding(.top, 20)
            
            VStack(alignment: .leading){
                Text("Operational Hours")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("DetailColor"))
                HStack{
                    Text("Everyday")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("10.00PM - 09.00AM")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.black)
            }
            .padding()
            .frame(width: 358, height: 59)
            .background(Color("FrameColor"))
            .cornerRadius(8)
            
            Spacer()
            
            Button {
                isPressed = true
            } label: {
                Text("Direction")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 358, height: 44)
                    .background(Color("ComponentColor"))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 20)
        .alert(alertTitle, isPresented: Binding(get: { !isSameFloor && isPressed },
                                                set: { _,_ in })){
            VStack{
                Button(getStringValue(from: Services.Staircase)){
                    setDetourPreference(to: Services.Staircase)
                    isPressed = false
                }
                Button(getStringValue(from: Services.Escalator)){
                    setDetourPreference(to: Services.Escalator)
                    isPressed = false
                }
                Button(getStringValue(from: Services.Elevator)){
                    setDetourPreference(to: Services.Elevator)
                    isPressed = false
                }
            }
        }
        //        .navigationBarBackButtonHidden()
    }
    func getStringValue(from service: Services) -> String {
        return service.rawValue
    }
    func setDetourPreference(to preference: Services) -> () {
        detourPreference = preference
    }
    func backButtonView() -> some View {
        return Button {
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
        }
    }
}
