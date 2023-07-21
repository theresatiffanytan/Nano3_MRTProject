//
//  StepLineIndicator.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepDivider: View {
    var isCompleted: Bool

    var body: some View {
        Capsule()
            .fill(isCompleted ? .green : .gray)
            .frame(height: 2)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct StepDivider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepDivider(isCompleted: true)
            StepDivider(isCompleted: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
