//
//  FirestoreManager.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 20/07/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreManager: ObservableObject {
    private let stationsCollectionRef = Firestore.firestore().collection("stations")
    private var cancellables = Set<AnyCancellable>()

    @Published var stations: [Station] = []

    init() {
        fetchData()
    }

    func fetchData() {
        stationsCollectionRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error retrieving collection: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                print("No documents in collection")
                return
            }

            let decoder = Firestore.Decoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            self.stations = documents.compactMap { queryDocumentSnapshot -> Station? in
                do {
                    let station = try queryDocumentSnapshot.data(as: Station.self, decoder: decoder)
                    return station
                } catch {
                    print("Error decoding station: \(error.localizedDescription)")
                    return nil
                }
            }
        }
    }

    func updateStation(_ station: Station) {
        do {
            guard let stationID = station.id else {
                print("Invalid station ID")
                return
            }

            let documentRef = stationsCollectionRef.document(stationID)
            try documentRef.setData(from: station)
        } catch {
            print("Error updating station: \(error.localizedDescription)")
        }
    }
}
