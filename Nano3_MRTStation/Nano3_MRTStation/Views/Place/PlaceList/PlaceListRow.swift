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
        HStack {
            Image("2")
                .resizable()
                .frame(width: 110, height: 80)
                .scaledToFit()
                .cornerRadius(8)
                .padding(.leading, 15)
            Spacer()
            VStack(alignment: .leading) {
                Text(place.name)
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                    .padding(.bottom, 1)
                    .padding(.top, 15)
                    .foregroundColor(.primary)
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 14))
                        .foregroundColor(.green)
                    
                    Text("\(place.location.formattedFloorLevel())")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                    Image(systemName: "location.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .padding(.leading, 10)
                    Text("\(place.location.getDistance()) m")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .frame(maxHeight: 107)
            .padding(.leading, -40)
            Spacer()
        }
        .frame(height: 107)
        .background(RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.gray.opacity(0.15)))
        .padding(.vertical, 3)
        
    }
}

struct PlaceListItem_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListItem(place: Place.dummyPlace[0])
            .previewLayout(.sizeThatFits)
    }
}
