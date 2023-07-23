//
//  AddPlaceView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//
import SwiftUI

enum Language : String, CaseIterable { // 1
    case swift
    case kotlin
    case java
    case javascript
}

struct AddPlaceView: View {
    @EnvironmentObject private var discoveryVM: DiscoveryViewModel
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var category: Place.PlaceCategory = .commercial
    @State private var status: Place.PlaceStatus = .open
    @State private var latitudeText: String = ""
    @State private var longitudeText: String = ""
    @State private var altitudeText: String = ""

    private var isFormFilled: Bool {
        return name.isEmpty || desc.isEmpty || latitudeText.isEmpty || longitudeText.isEmpty || altitudeText.isEmpty
    }

    private func resetProperty() {
        name = ""
        desc = ""
        latitudeText = ""
        longitudeText = ""
        altitudeText = ""
    }

    var body: some View {
        VStack {
            Text("Add Place to Station")
            Form {
                Section(header: Text("Station")) {
                    Picker("Name", selection: $discoveryVM.selectedStation) { // 3
                        ForEach(discoveryVM.stations) { station in
                            Text(station.name).tag(station)
                        }
                    }
                }
                Section(header: Text("Place Details")) {
                    TextField("Name", text: $name)
                    TextField( "Description", text: $desc)
                    Picker("Location", selection: $category) { // 3
                        ForEach(Place.PlaceCategory.allCases, id: \.self) { item in
                            Text(item.rawValue).tag("")
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Status")
                        Picker("Status", selection: $status) { // 3
                            ForEach(Place.PlaceStatus.allCases, id: \.self) { item in
                                Text(item.rawValue).tag("")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                Section(header: Text("Location")) {
                    TextField("Latitude", text: $latitudeText)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Longitude", text: $longitudeText)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Altitude", text: $altitudeText)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Button(action: addPlace) {
                    Text("Add Place")
                }
                .disabled(isFormFilled)

            }
            List(discoveryVM.stations) { station in
                VStack(alignment: .leading) {
                    Text("Station: \(station.name)")
                        .font(.headline)

                    Text("Places:")
                        .font(.subheadline)

                    ForEach(station.places, id: \.self) { place in
                        Text("- \(place.name)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            discoveryVM.fetchData()
        }
    }

    private func addPlace() {
        guard let selectedStation = discoveryVM.selectedStation else {
            print("Station is not selected")
            return
        }
        guard let latitude = Double(latitudeText),
              let longitude = Double(longitudeText),
              let altitude = Double(altitudeText) else {
            print("Invalid input for latitude, longitude, or altitude")
            return
        }

        let newPlace = Place(
            name: name,
            description: desc,
            photo: "",
            category: category,
            status: status,
            location: Location(latitude: latitude, longitude: longitude, altitude: altitude)
        )
        discoveryVM.addPlaceToStation(stationID: selectedStation.id ?? "", place: newPlace)
        resetProperty()
    }}


struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView()
            .environmentObject(DiscoveryViewModel())
    }
}
