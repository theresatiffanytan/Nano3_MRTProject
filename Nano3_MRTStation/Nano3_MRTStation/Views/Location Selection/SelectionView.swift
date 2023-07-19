//
//  SelectionView.swift
//  Nano3_MRTStation
//
//  Created by Randy Julian on 19/07/23.
//

import SwiftUI

struct SelectionView: View {
    
    @State private var selected = 0
    private let options = ["List", "Map View"]
    
    var body: some View {
        VStack {
            Picker(selection: $selected, label: Text("Options")){
                ForEach(0..<options.count) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onAppear {
                UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            }
            Spacer()
            VStack{
                switch selected {
                case 0:
                    ListView()
                        .padding(.all, -18)
                case 1:
                    EmptyView()
//                    MapView()
                default:
                    EmptyView()
                }
            }
            .padding()
            Spacer()
            
        }
        .padding()
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
