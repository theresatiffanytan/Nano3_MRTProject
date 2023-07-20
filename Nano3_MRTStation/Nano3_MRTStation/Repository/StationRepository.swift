//
//  StationRepository.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//

import Combine

class StationRepository: ObservableObject {
    private let firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()

    @Published var stations: [Station] = []

    init() {
        setupBindings()
    }

    private func setupBindings() {
        firestoreManager.$stations
            .assign(to: \.stations, on: self)
            .store(in: &cancellables)
    }

    func updateStation(_ station: Station) {
        firestoreManager.updateStation(station)
    }
}
