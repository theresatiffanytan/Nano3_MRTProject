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
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            Text(name)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

struct PlaceCategoryGridItem_Previews: PreviewProvider {
    static var previews: some View {
        PlaceCategoryGridItem(image: "square.fill", name: "Shops")
    }
}
