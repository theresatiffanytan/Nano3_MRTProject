//
//  AccessOptPicker.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 21/07/23.
//

import SwiftUI

struct AccessOptPicker: View {
    @Binding var selectedDetour: Place.PlaceCategory.AccessibilityType

    var body: some View {
        HStack {
            OptPicker(detour: .escalator, selectedDetour: selectedDetour)
                .onTapGesture {
                    selectedDetour = .escalator
                }
            Spacer()
            Divider()
            Spacer()
            OptPicker(detour: .lift, selectedDetour: selectedDetour)
                .onTapGesture {
                    selectedDetour = .lift
                }
            Spacer()
            Divider()
            Spacer()
            OptPicker(detour: .stairs, selectedDetour: selectedDetour)
                .onTapGesture {
                    selectedDetour = .stairs
                }
        }
        .fixedSize(horizontal: false, vertical: true)
        .animation(.spring(), value: selectedDetour)
    }
}

struct AccessOptPicker_Previews: PreviewProvider {
    static var previews: some View {
        AccessOptPicker(selectedDetour: .constant(.escalator))
    }
}

struct OptPicker: View {
    let detour: Place.PlaceCategory.AccessibilityType
    let selectedDetour: Place.PlaceCategory.AccessibilityType

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(detour.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28)
                Text(detour.rawValue)
                    .font(.caption2)
            }
            .foregroundColor(detour == selectedDetour ? .white : .accentColor)
            Spacer()
        }
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 8)
            .foregroundColor( detour == selectedDetour ? .accentColor : Color(uiColor: .systemGray6)
            )
        )
        .fixedSize(horizontal: false, vertical: false)
    }
}
