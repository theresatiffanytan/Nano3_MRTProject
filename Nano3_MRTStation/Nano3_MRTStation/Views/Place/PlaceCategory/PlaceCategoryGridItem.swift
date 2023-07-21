//
//  PlaceCategoryGridItem.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct PlaceCategoryGridItem: View {
    let image: String
    let name: String

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 106, height: 106)
                    .foregroundColor(Color("LightBlue"))
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52, height: 52)
                .foregroundColor(.blue)
            }
            Text(name)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

struct PlaceCategoryGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCategoryGridItem(image: "mosque 1", name: "Shops")
    }
}
