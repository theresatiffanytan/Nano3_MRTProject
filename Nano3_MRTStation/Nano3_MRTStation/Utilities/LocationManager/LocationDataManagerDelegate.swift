//
//  CLLocationManagerDelegate.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import CoreLocation
import UserNotifications

extension LocationDataManager: CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location

        distance = currentLocation.distance(from: targetLocation)
        print(distance.distanceDesc)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else { return }
        currentHeading = newHeading
        
        let targetBearing = calculateTargetBearing()
        heading = targetBearing - currentHeading.magneticHeading
        headingDesc = formatHeading(heading)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("⚠️ Error while updating location: \(error.localizedDescription)")
    }
    
#if os(iOS)
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let region = region as? CLCircularRegion else { return }
        print("User enter \(region.identifier)")
        didArrived = true
        stopTrip()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard let region = region as? CLCircularRegion else { return }
        print("User leave \(region.identifier)")
    }
    

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        guard let region = region else {
            print("The region could not be monitored, and the reason for the failure is not known.")
            return
        }
        print("⚠️ Error in monitoring the region with a identifier: \(region.identifier)")
    }
#endif

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("Received Notification")
        completionHandler()
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("Received Notification in Foreground")
        completionHandler(.sound)
    }

    private func calculateTargetBearing() -> Double {
        let deltaLongitude = targetLocation.coordinate.longitude.radians - currentLocation.coordinate.longitude.radians
        let thetaB = targetLocation.coordinate.latitude.radians
        let thetaA = currentLocation.coordinate.latitude.radians
        
        let x = cos(thetaB) * sin(deltaLongitude)
        let y = cos(thetaA) * sin(thetaB) - sin(thetaA) * cos(thetaB) * cos(deltaLongitude)
        let bearing = atan2(x, y)
        
        return bearing.degrees
    }
    
    private func formatHeading(_ heading: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        let directionMessages = [
            "You're on track",
            "Slightly head to the right",
            "Significantly head to the right",
            "You're way off course, head to the right",
            "You're going in the opposite direction, turn around",
            "You're way off course, head to the left",
            "Significantly head to the left",
            "Slightly head to the left"
        ]
        
        var normalizedHeading = (heading + 360).truncatingRemainder(dividingBy: 360)
        if normalizedHeading < 0 {
            normalizedHeading += 360
        }
        
        let directionIndex = Int((normalizedHeading / 45.0).rounded(.toNearestOrAwayFromZero)) % 8
        //        let formattedValue = formatter.string(from: NSNumber(value: normalizedHeading)) ?? ""
        
        return directionMessages[directionIndex]
    }
}

extension Double {
    var radians: Double {
        Measurement(value: self, unit: UnitAngle.degrees).converted(to: .radians).value
    }
    
    var degrees: Double {
        Measurement(value: self, unit: UnitAngle.radians).converted(to: .degrees).value
    }
    
    var meters: Double {
        Measurement(value: self, unit: UnitLength.meters).value
    }
    
    var kilometers: Double {
        Measurement(value: self / 1000, unit: UnitLength.kilometers).value
    }

    var distanceDesc: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1

        let distanceInMeters = self.meters
        var formattedValue = ""
        var unit = ""

        if distanceInMeters < 1000 {
            formattedValue = formatter.string(from: NSNumber(value: distanceInMeters)) ?? ""
            unit = "m"
        } else {
            let distanceInKilometers = self.kilometers
            formattedValue = formatter.string(from: NSNumber(value: distanceInKilometers)) ?? ""
            unit = "km"
        }
        return "\(formattedValue) \(unit)"
    }
}
