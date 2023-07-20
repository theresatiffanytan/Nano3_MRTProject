//
//  PlaceListRow.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import SwiftUI

struct PlaceListRow: View {
    let place: Place
    var body: some View {
        VStack(alignment: .leading) {
            Text(place.name)
                .font(.headline)
            Text(place.description)
                .font(.subheadline)
                .padding(.top, 2)
        }
    }
}

struct PlaceListRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListRow(place: Place.dummyPlace[0])
        .previewLayout(.sizeThatFits)
    }
}
