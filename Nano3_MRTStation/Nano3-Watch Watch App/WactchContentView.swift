//
//  ContentView.swift
//  Nano3-Watch Watch App
//
//  Created by Adriel Bernard Rusli on 16/07/23.
//

import SwiftUI
import WatchConnectivity
import WatchKit

struct WactchContentView: View {
    @StateObject private var watchViewModel = WatchViewModel.shared
    @State private var isShowing = false
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                if let receivedPlace = watchViewModel.receivedPlace {
                    
                    Text(receivedPlace.name)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .position(x: geometry.size.width/2 , y: geometry.size.height * 0.4)
                    
                    Button{
                        isShowing = true
                        generateHapticFeedback()
                    }label: {
                        Text("Start")
                            .foregroundColor(Color.black)
                    }.background(Color("AppGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .frame(height: 51)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height * 0.95)
                    .fullScreenCover(isPresented: $isShowing) {
                        WatchCompassView(isShowing: $isShowing, targetplace:receivedPlace)
                    }
                    
                    
                } else {
                    Image("LogoMRT")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 108)
                        .position(x: geometry.size.width / 2 , y: geometry.size.height * 0.4)

                    Text("Awaiting data")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .position(x: geometry.size.width / 2 , y: geometry.size.height * 1.05 )
                    //                    .frame(width: uiscre)
                    //

                }
            }
        }
        .padding()
        .onAppear {
            watchViewModel.sendMessage()
        }
        
    }
    func generateHapticFeedback() {
        // Provide the desired haptic feedback type
        WKInterfaceDevice.current().play(.click)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WactchContentView()
    }
}
