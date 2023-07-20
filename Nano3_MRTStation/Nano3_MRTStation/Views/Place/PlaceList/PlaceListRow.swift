//
//  PlaceListRow.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

struct PlaceListItem: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .font(.headline)
            Text("Desc: \(place.description)")
                .font(.subheadline)
                .padding(.top, 2)
            Text("Category: \(place.category.rawValue)")
                .font(.subheadline)
            Text("Status: \(place.status.rawValue)")
                .font(.subheadline)
            Text("Distance: \(place.distance) Meters")
                .font(.subheadline)
        }
    }
}

struct PlaceListItem_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListItem(place: Place.dummyPlace[0])
            .previewLayout(.sizeThatFits)
    }
}
