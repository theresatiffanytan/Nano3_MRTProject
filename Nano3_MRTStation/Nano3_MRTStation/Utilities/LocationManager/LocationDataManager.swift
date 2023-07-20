//
//  LocationDataManager.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import CoreLocation
import UserNotifications

class LocationDataManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    var targetLocation = CLLocation()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation = CLLocation()
    @Published var currentHeading = CLHeading()
    @Published var heading: Double = 0.0
    @Published var headingDesc: String = ""
    @Published var distance: CLLocationDistance = 0.0
    @Published var distanceDesc: String = ""

    var storeRegion: CLCircularRegion?
    @Published var didArriveAtTakeout = false


    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
    }

    func validateLocationAuthorizationStatus() {
        let status = locationManager.authorizationStatus
        authorizationStatus = status

        switch status {
        case .notDetermined:
            print("Location Services Not Determined")
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location Services Not Authorized")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location Services Authorized")
            startLocationUpdates()
        @unknown default:
            break
        }
    }

    func startLocationUpdates() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func startHeadingUpdates() {
        locationManager.startUpdatingHeading()
    }

    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    func startMonitoringRegion(center: CLLocation, identifier: String) {
        targetLocation = center
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let regionRadius: CLLocationDistance = 5
            let region = CLCircularRegion(center: center.coordinate, radius: regionRadius, identifier: identifier)
            region.notifyOnEntry = true
            storeRegion = region

            locationManager.startMonitoring(for: region)
            print("Region monitoring is started.")
        } else {
            print("Region monitoring is not available.")
        }
    }

    func stopMonitoringRegion() {
        guard let storeRegion = storeRegion else { return }
        locationManager.stopMonitoring(for: storeRegion)
    }
}


extension CLLocation {
    func toLocation() -> Location {
        return Location(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude, altitude: self.altitude)
    }
}
