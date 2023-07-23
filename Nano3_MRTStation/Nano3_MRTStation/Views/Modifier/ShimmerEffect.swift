//
//  ShimmerEffect.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 23/07/23.
//

import SwiftUI

struct ShimmerEffect: ViewModifier {
    @State private var moveTo: CGFloat = -0.7
    var tint: Color
    var highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 2

    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay {
                Rectangle()
                    .fill(tint)
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = size.height / 2.5

                            Rectangle()
                                .fill(.linearGradient(colors: [
                                    .white.opacity(0),
                                    highlight.opacity(highlightOpacity),
                                    .white.opacity(0)
                                ], startPoint: .top, endPoint: .bottom)
                                )
                                .blur(radius: blur)
                                .rotationEffect(.init(degrees: -70))
                                .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                .offset(x: size.width * moveTo)
                        }
                    }
                    .mask {
                        content
                    }
            }
            .onAppear {
                DispatchQueue.main.async {
                    moveTo = 0.7
                }
            }
            .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: moveTo)
    }
}

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerEffect(tint:                     Color(uiColor: .systemGray4), highlight: .white.opacity(0.4)))
    }
}

struct ShimmerEffect_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .font(.title)
            .shimmering()
            .previewLayout(.sizeThatFits)
    }
}
