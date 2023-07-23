//
//  ContentView.swift
//  Nano3 MRT Watch App
//
//  Created by Adriel Bernard Rusli on 20/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var watchViewModel = WatchViewModel.shared
    @State private var isShowing = false
    var body: some View {
        VStack {
          
            GeometryReader { geometry in
                if !watchViewModel.receivedDestionation.isEmpty{
                    
                    Text(watchViewModel.receivedDestionation[0].name)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .position(x: geometry.size.width/2 , y: geometry.size.height * 0.4)
                    
                    Button{
                        isShowing = true
                    
                    }label: {
                        Text("Start")
                            .foregroundColor(Color.black)
                    }.background(Color("AppGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .frame(height: 51)
                    .position(x: geometry.size.width / 2 , y: geometry.size.height * 0.95)
                    .fullScreenCover(isPresented: $isShowing) {
                        WatchCompassView(isShowing: $isShowing, destinations: watchViewModel.receivedDestionation)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
