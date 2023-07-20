//
//  FirebaseViewModel.swift
//  Nano3_MRTStation
//
//  Created by Abner Edgar on 20/07/23.
//

import Foundation
import Firebase

class FirebaseViewModel: ObservableObject {
    
    @Published var currentStation: Station
    @Published var verticalTransports: [Place] = []
    
    init(station: Station) {
        currentStation = station
        self.retrieveTransportData(from: currentStation.name)
    }
    
    func retrieveTransportData(from dbName: String) -> (){
        
        // Get reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection(dbName).getDocuments { snapshot, error in
            
            if error == nil {
                // No errors
                if let snapshot = snapshot {
                    // Not Empty
                    
                    DispatchQueue.main.async {
                        
                        self.verticalTransports = snapshot.documents.map { d in
                            
//                            let tempLoc = d["geoloc"].map { tempData in
//                                Location(latitude: tempData["Latitude"] as? Double ?? 0,
//                                         longitude: tempData["Longitude"] as? Double ?? 0,
//                                         altitude: 0)
//                            }
                                
                            return Place(name: d["name"] as? String ?? "",
                                         description: "",
                                         photo: "",
                                         category: .escalators,
                                         location: Location(latitude: 0, longitude: 0, altitude: 0),
                                         status: Place.Status.closed)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    func appendTransport() {
        
    }
    
}
