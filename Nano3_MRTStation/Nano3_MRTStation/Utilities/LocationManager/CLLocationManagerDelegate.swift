//
//  CLLocationManagerDelegate.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import CoreLocation

extension LocationDataManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        
        distance = currentLocation.distance(from: targetLocation)
        distanceDesc = formatDistance(distance)
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
        didArriveAtTakeout = true
        print("User enter \(region.identifier)")
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
        let directionMessage = directionMessages[directionIndex]
        
        let formattedValue = formatter.string(from: NSNumber(value: normalizedHeading)) ?? ""
        
        return "\(formattedValue)°\n\(directionMessage)"
    }
    
    private func formatDistance(_ distance: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        let distanceInMeters = distance.meters
        var formattedValue = ""
        var unit = ""
        
        if distanceInMeters < 1000 {
            formattedValue = formatter.string(from: NSNumber(value: distanceInMeters)) ?? ""
            unit = distanceInMeters == 1 ? "meter" : "meters"
        } else {
            let distanceInKilometers = distance.kilometers
            formattedValue = formatter.string(from: NSNumber(value: distanceInKilometers)) ?? ""
            unit = distanceInKilometers == 1 ? "kilometer" : "kilometers"
        }
        return "\(formattedValue) \(unit) away"
    }
    
}

private extension Double {
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
}
