//
//  StepIndicator.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

struct StepIndicator: View {
    let isCompleted: Bool
    let text: String
    let indicatorSize: CGFloat

    var body: some View {
        Group {
            if isCompleted {
                completedStepView
            } else {
                incompleteStepView
            }
        }
        .frame(width: 48)
        .overlay(alignment: .bottom) {
            Text(text)
                .foregroundColor(.secondary)
                .font(.caption)
                .multilineTextAlignment(.center)
                .offset(y: 40)
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
            .frame(width: indicatorSize)
            .foregroundColor(Color(uiColor: .systemGray5))
            .overlay {
                Circle()
                    .foregroundColor(Color(uiColor: .systemGray3))
                    .frame(height: 16)
            }
    }
}

struct StepIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StepIndicator(isCompleted: true, text: "Starting Point", indicatorSize: 32)
            StepIndicator(isCompleted: false, text: "End Point", indicatorSize: 32)
        }
        .previewLayout(.sizeThatFits)
    }
}
