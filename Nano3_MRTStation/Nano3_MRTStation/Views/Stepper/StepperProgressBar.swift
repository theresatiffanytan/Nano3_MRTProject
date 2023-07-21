//
//  StepperView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepperProgressBar: View {
    let destinations: [Place]
    var indicatorSize: CGFloat = 24

    var body: some View {
        HStack(spacing: 0) {
            StepIndicator(text: "Start",
                          progress: .completed,
                          indicatorSize: indicatorSize)
            ForEach(destinations, id: \.self) { destination in
                StepDivider(progress: destination.progress)
                StepIndicator(text: destination.name,
                              progress: destination.progress,
                              indicatorSize: indicatorSize
                )
            }
        }
    }
}

struct StepperProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        StepperProgressBar(destinations: [Place.dummyPlace[1], Place.dummyPlace[2]])
            .previewLayout(.sizeThatFits)
    }
}
