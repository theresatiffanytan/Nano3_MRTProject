//
//  LocationDataManager.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import CoreLocation
import UserNotifications

class LocationDataManager: NSObject, ObservableObject{
    static let shared = LocationDataManager()
    private let locationManager = CLLocationManager()
    var targetLocation = CLLocation()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation = CLLocation()
    @Published var currentHeading = CLHeading()
    @Published var heading: Double = 0.0
    @Published var headingDesc: String = ""
    @Published var distance: CLLocationDistance = 0.0

    var storeRegion: CLCircularRegion?
    @Published var didArrived = false
    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()
        setupLocationManager()
        setupNotificationCenter()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
    }

    private func setupNotificationCenter() {
        notificationCenter.delegate = self
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
        print("Location update is started.")
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        print("Location update is stopped.")
    }

    func startHeadingUpdates() {
        locationManager.startUpdatingHeading()
        print("Heading update is started.")
    }

    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
        print("Heading update is stopped.")
    }

    #if os(iOS)
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
        print("Region monitoring is stopped.")
    }
    #endif

    func requestNotificationAuthorization() {
        let options: UNAuthorizationOptions = [.sound, .alert]
        notificationCenter
            .requestAuthorization(options: options) { [weak self] result, _ in
                print("Notification Auth Request result: \(result)")
                if result {
                    self?.registerNotification()
                }
            }
    }

    private func registerNotification() {
        guard let storeRegion = storeRegion else { return }
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "You've arrived to \(storeRegion.identifier)"
//        notificationContent.body = storeRegion.identifier
        notificationContent.sound = .default

        let trigger = UNLocationNotificationTrigger(
            region: storeRegion,
            repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notificationContent,
            trigger: trigger)

        notificationCenter
            .add(request) { error in
                if error != nil {
                    print("Error: \(String(describing: error))")
                }
            }
    }
}

extension CLLocation {
    func toLocation() -> Location {
        return Location(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude, altitude: self.altitude)
    }
}

