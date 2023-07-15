//
//  ContentView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            PlaceListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DiscoveryViewModel())
    }
}





