//
//  ContentView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//
import SwiftUI

struct ContentView: View {
    #if DEBUG
    @State private var showPlaceView = false
    #endif

    var body: some View {
        NavigationStack {
            PlaceCategoryGridView()
                #if DEBUG
                .onLongPressGesture(minimumDuration: 3) {
                    showPlaceView.toggle()
                }
                .sheet(isPresented: $showPlaceView) {
                    AddPlaceView()
                }
                #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
