//
//  LocationAuthStateView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 13/07/23.
//

import SwiftUI
import CoreLocation

struct LocationStateView<Content: View>: View {
    let authorizationStatus: CLAuthorizationStatus
    let content: Content

    init(authorizationStatus: CLAuthorizationStatus, @ViewBuilder content: () -> Content) {
        self.authorizationStatus = authorizationStatus
        self.content = content()
    }

    var body: some View {
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            content
        case .restricted, .denied:
            Text("Current location data is restricted or denied.")
        case .notDetermined:
            VStack {
                Text("Finding your location...")
                ProgressView()
            }
        @unknown default:
            ProgressView()
        }
    }
}

struct AuthorizationStatusView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationStateView(authorizationStatus: .authorizedWhenInUse) {
                Text("Authorized content")
                    .font(.title)
            }
            LocationStateView(authorizationStatus: .restricted) {
                Text("Authorized content")
                    .font(.title)
            }
            LocationStateView(authorizationStatus: .notDetermined) {
                Text("Authorized content")
                    .font(.title)
            }
        }
    }
}

