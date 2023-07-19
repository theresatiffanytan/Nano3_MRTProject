//
//  ListView.swift
//  Nano3_MRTStation
//
//  Created by Randy Julian on 19/07/23.
//

import SwiftUI

struct ListView: View {
    
    //    @State var width = UIScreen.main.bounds.width * 0.9
    //    @State var height = UIScreen.main.bounds.height * 0.2
    var body: some View {
        List {
            ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                CardView()
                    .listRowSeparator(.hidden)
                
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

