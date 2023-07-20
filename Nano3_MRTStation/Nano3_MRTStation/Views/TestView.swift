//
//  TestView.swift
//  Nano3_MRTStation
//
//  Created by Adriel Bernard Rusli on 16/07/23.
//

import SwiftUI
import WatchConnectivity

struct TestView: View {
    @ObservedObject private var watchViewModel = WatchViewModel.shared
    var body: some View {
        
        Button{
            watchViewModel.sendMessage()
        }label: {
            Text("Test")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
