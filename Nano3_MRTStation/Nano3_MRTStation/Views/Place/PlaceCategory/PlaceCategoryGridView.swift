//
//  PlaceCategoryGridView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//

import SwiftUI

struct PlaceCategoryGridView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    @EnvironmentObject var locationManager: LocationDataManager
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Picker("Station", selection: $discoveryVM.selectedStation) {
                    ForEach(discoveryVM.stations) { station in
                        Text(station.name).tag(station)
                    }
                }
                .padding(.leading, 14)
                .overlay(alignment: .leading) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 14))
                }
                Spacer()
            }
            .foregroundColor(.accentColor)
            Text("Choose facility you would like us to direct")
                .font(.title2)
                .bold()
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Place.PlaceCategory.allCases, id: \.self) { category in
                    NavigationLink(destination: PlaceListView(category: category)) {
                        PlaceCategoryGridItem(image: category.icon, name: category.rawValue)
                    }
                }
            }
            .padding(.top, 4)
            Spacer()
        }
        .padding()
        .onAppear {
            locationManager.validateLocationAuthorizationStatus()
        }
    }
}

struct PlaceCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCategoryGridView()
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}
