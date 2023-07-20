//
//  DiscoveryViewModel.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Combine

class DiscoveryViewModel: ObservableObject {
    @Published var stations: [Station] = []
    @Published var selectedStation: Station?
    private let stationRepository = StationRepository()
    private var cancellables = Set<AnyCancellable>()
    
    //perubahan Abner
    @Published var destinations: [Place] = []
    @Published var isSameFloor: Bool = false
    // ambil escalator turun masukin ke detourPlace
    @Published var detourPlace: Place? = nil
    

    init() {
        fetchData()
    }

    func fetchData() {
        stationRepository.$stations
            .sink { [weak self] fetchedStations in
                self?.stations = fetchedStations
                self?.selectedStation = fetchedStations.first
            }
            .store(in: &cancellables)
    }

    func selectStation(_ station: Station) {
        selectedStation = station
    }

    func getPlaceCategories() -> [Place.PlaceCategory] {
        guard let selectedStation = selectedStation else {
            return []
        }
        let categories = selectedStation.places.map { $0.category }
        let uniqueCategories = Array(Set(categories))
        return uniqueCategories.sorted(by: { $0.rawValue < $1.rawValue })
    }

    func getPlacesFiltered(by category: Place.PlaceCategory) -> [Place] {
        guard let selectedStation = selectedStation else {
            return []
        }
        let filteredPlaces = selectedStation.places.filter { $0.category == category }
        let sortedPlaces = filteredPlaces.sorted { $0.distance < $1.distance }

        return sortedPlaces
    }

    func addPlaceToStation(stationID: String, place: Place) {
        guard let station = findStationByID(stationID) else {
            print("Station not found")
            return
        }

        var updatedStation = station
        updatedStation.places.append(place)

        stationRepository.updateStation(updatedStation)
    }

    private func findStationByID(_ stationID: String) -> Station? {
        return stations.first { $0.id == stationID }
    }
    
    //perubahan Abner
    
    func appendDestination(to targetPlace: Place) -> () {
        destinations.append(targetPlace)
        updateIsSameFloor()
    }
    
    func clearDestination() -> () {
        destinations = []
    }
    
    func appendDetour() -> () {
        guard let detour = detourPlace, !isSameFloor else { return }
        destinations.insert(detour, at: 0)
    }
    
    func updateIsSameFloor() -> () {
        // MARK: -- Problem if the floor level is more than 2
        isSameFloor = LocationDataManager.shared.currentLocation.toLocation().floorLevel == destinations.first?.location.floorLevel
    }
}
