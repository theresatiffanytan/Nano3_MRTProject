//
//  DiscoveryViewModel.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Foundation

class DiscoveryViewModel: ObservableObject {
    @Published var currentStation = Station.dummyStations[0]
}
