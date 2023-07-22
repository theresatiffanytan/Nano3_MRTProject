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
        HStack(alignment: .top) {
            // TODO: Change image with place.image
            Image("2")
                .resizable()
                .frame(width: 110, height: 80)
                .scaledToFit()
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                HStack(alignment: .top) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.accentColor)
                    Text(place.location.formattedFloorLevel())
                        .foregroundColor(.gray)
                    Image(systemName: "location.fill")
                        .foregroundColor(.accentColor)
                        .padding(.leading, 8)
                    Text("\(place.distance.distanceDesc)")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                }
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.top, 2)
            }
            .padding(.leading, 8)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 8)
        .foregroundColor(Color(uiColor: .systemGray6)))
    }
}

struct PlaceListRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListRow(place: Place.dummyPlace[0])
            .previewLayout(.sizeThatFits)
    }
}
