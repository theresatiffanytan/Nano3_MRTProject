//
//  DiscoveryViewModel.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 14/07/23.
//

import Combine
import CoreLocation

class DiscoveryViewModel: ObservableObject {
    @Published var stations: [Station] = []
    @Published var selectedStation: Station?
    private let stationRepository = StationRepository()
    private var cancellables = Set<AnyCancellable>()
    @Published var destinations: [Place] = []
    @Published var isSameFloor: Bool = false
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
    
    func getPlacesFiltered(by category: Place.PlaceCategory, from currentLocation: CLLocation) -> [Place] {
        print("KEPANGGIL")
        guard let selectedStation = selectedStation else {
            return []
        }
        var filteredPlaces = selectedStation.places.filter { $0.category == category }
        
        filteredPlaces = filteredPlaces.map { place in
            var updatedPlace = place
            updatedPlace.distance = currentLocation.distance(from: place.location.toCLLocation())
            return updatedPlace
        }
        
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
    
    
    
    func clearDestinations() -> () {
        destinations = []
    }
    
    func removeDetour() -> () {
        guard destinations.count > 1 else { return }
        destinations.remove(at: 0)
    }
    
    func appendDetour() -> () {
        guard let detour = detourPlace, !isSameFloor else { return }
        destinations.insert(detour, at: 0)
    }
    
    func updateIsSameFloor() -> () {
        isSameFloor = LocationDataManager.shared.currentLocation.toLocation().floorLevel == destinations.first?.location.floorLevel
        //MARK: -_ Temporary change dummyLevel with any floor level
        let dummyLevel = 3
        isSameFloor = dummyLevel == destinations.first?.location.floorLevel
        
    }
    
    func updateNearestDetour(type selectedDetour: Place.PlaceCategory.AccessibilityType, from places: [Place]) -> () {
        let filteredDetours = places.filter {
            $0.getAccessibilityType() == selectedDetour
        }
        guard !filteredDetours.isEmpty else {
            print("No detours available for the selected accessibility type.")
            return 
        }

        // Calculate and return the nearest detour based on your desired logic
        // For example, if you have a user location and want to find the nearest detour, you can implement that logic here.

        // Replace the following line with your logic to find the nearest detour.
        detourPlace = filteredDetours.first
    }
}
