//
//  StepIndicator.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepIndicator: View {
    let text: String
    let progress: Place.PlaceProgress
    let indicatorSize: CGFloat

    var body: some View {
        Group {
            switch progress {
            case .completed:
                completedStepView
            case .ongoing, .pending:
                incompleteStepView
            }
        }
        .frame(maxWidth: 48)
        .overlay(alignment: .center) {
            Text(text)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .offset(y: 24)
        }
        .padding(.horizontal, 2)
    }

    private var completedStepView: some View {
        Circle()
            .frame(width: indicatorSize)
            .foregroundColor(.green)
            .overlay {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
    }

    private var incompleteStepView: some View {
        Circle()
            .foregroundColor(progress == .ongoing ? .accentColor : Color(uiColor: .systemGray4))
            .frame(width: indicatorSize)
            .overlay {
                Circle()
                    .strokeBorder(.white, lineWidth: 2)
                    .frame(height: indicatorSize - 4)
            }
    }
}

struct StepIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepIndicator(text: "Starting Point", progress: .completed, indicatorSize: 32)
            StepIndicator(text: "End Point", progress: .ongoing, indicatorSize: 32)
            StepIndicator(text: "End Point", progress: .pending, indicatorSize: 32)
        }
        .previewLayout(.sizeThatFits)
    }
}
