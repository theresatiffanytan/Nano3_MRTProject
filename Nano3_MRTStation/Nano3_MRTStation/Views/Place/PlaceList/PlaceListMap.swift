//
//  PlaceListMapView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 21/07/23.
//

import SwiftUI

struct PlaceListMap: View {
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = CGSize.zero
    
    func resetImageState() {
        
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
            
        }
    }
    
    var body: some View {
        ZStack{
            
            Color.clear
            Image("Maps")
                .resizable()
                .aspectRatio(contentMode: .fit)
            //                .padding()
                .opacity(isAnimating ? 1: 0)
                .animation(.linear(duration: 1), value: isAnimating)
                .offset(x: imageOffset.width, y: imageOffset.height)
                .scaleEffect(imageScale)
            
            //TAP GESTURE
                .onTapGesture(count: 2) {
                    if imageScale == 1 {
                        withAnimation(.spring()){
                            imageScale = 5
                            
                        }
                    }else{
                        resetImageState()
                        
                    }
                }
            //DRAG GESTURE
                .gesture(DragGesture()
                    .onChanged{ value in
                        withAnimation(.linear(duration: 1)){
                            if imageScale <= 1  {
                                imageOffset = value.translation
                            }else{
                                imageOffset = value.translation
                                
                            }
                            
                            
                        }
                    }
                    .onEnded{ value in
                        if imageScale <= 1 {
                            resetImageState()
                        }
                        
                        
                    }
                )
            //MAGIFICATION
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 1)){
                                if imageScale >= 1 && imageScale <= 5 {
                                    imageScale = value
                                } else if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                        .onEnded{ _ in
                            
                            if imageScale > 7 {
                                imageScale = 7
                            } else if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                    
                    
                )
            
        }
        .onAppear {
            withAnimation(.linear(duration: 1)){
                isAnimating = true
            }
        }
    }
}

struct PlaceListMap_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListMap()
    }
}
