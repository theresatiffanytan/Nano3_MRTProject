//
//  StepperView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepperProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    var indicatorSize: CGFloat = 32

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<totalSteps, id: \.self) { step in
                StepIndicator(
                    isCompleted: step < currentStep,
                    text: "Starting Point",
                    indicatorSize: indicatorSize)
                if step != totalSteps - 1 {
                    StepDivider(isCompleted: step < currentStep)
                }
            }
        }
    }
}

struct StepperProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StepperProgressBar(currentStep: 2, totalSteps: 4)
            .previewLayout(.sizeThatFits)
    }
}
