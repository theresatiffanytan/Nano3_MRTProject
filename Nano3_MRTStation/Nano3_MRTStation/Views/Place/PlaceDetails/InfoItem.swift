//
//  InfoCard.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 21/07/23.
//

import SwiftUI

struct InfoItem: View {
    let image: String
    let title: String
    let text: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack{
            Image(systemName: image)
                .font(.system(size: 12))
                .foregroundColor(.accentColor)
                .background(
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.1) : Color("CircleColor")))
            VStack(alignment: .leading){
                Text(title)
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray))
                Text(text)
                    .font(.footnote)
                    .fontWeight(.medium)
            }
            .padding(.leading, 8)
        }
    }
}

struct InfoItem_Previews: PreviewProvider {
    static var previews: some View {
        InfoItem(
            image: "mappin.and.ellipse",
            title: "Location",
            text: "2nd Floor")
    }
}
