//
//  PlaceCategoryGridView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//

import SwiftUI

struct PlaceCategoryGridView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Place.PlaceCategory.allCases, id: \.self) { category in
                    NavigationLink(destination: PlaceListView(category: category)) {
                        PlaceCategoryGridItem(image: category.icon, name: category.rawValue)
                    }
                }
            }
        }
        .padding()
        .navigationTitle(discoveryVM.selectedStation?.name ?? "No Station")
    }
}

struct PlaceCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCategoryGridView()
            .environmentObject(DiscoveryViewModel())
            .environmentObject(LocationDataManager())
    }
}

