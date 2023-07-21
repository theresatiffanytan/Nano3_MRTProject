//
//  StepLineIndicator.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepDivider: View {
    let progress: Place.PlaceProgress

    var body: some View {
        Capsule()
            .fill(progress == .completed ? .green : progress == .ongoing ? .accentColor : Color(uiColor: .systemGray4))
            .frame(height: 3)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct StepDivider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepDivider(progress: .completed)
            StepDivider(progress: .ongoing)
            StepDivider(progress: .pending)
        }
        .previewLayout(.sizeThatFits)
    }
}
