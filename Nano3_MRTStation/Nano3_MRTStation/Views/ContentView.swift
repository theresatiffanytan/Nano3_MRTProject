//
//  ContentView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//
import SwiftUI

struct ContentView: View {
    @State private var showPlaceView = false

    var body: some View {
        NavigationStack {
            PlaceCategoryGridView()
                .onLongPressGesture(minimumDuration: 3) {
                    showPlaceView.toggle()
                }
                .sheet(isPresented: $showPlaceView) {
                    AddPlaceView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
