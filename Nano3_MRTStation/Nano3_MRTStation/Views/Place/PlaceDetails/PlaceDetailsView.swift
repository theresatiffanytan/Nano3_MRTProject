//
//  PlaceDetailsView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 21/07/23.
//

import SwiftUI

struct PlaceDetailsView: View {
    @EnvironmentObject var discoveryVM: DiscoveryViewModel
    // MARK: Temporary
    @State private var selectedDetour: Place.PlaceCategory.AccessibilityType = .escalator
    let place: Place

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text(place.category.rawValue)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .systemGray2))
                    Text(place.name)
                        .font(.title2)
                        .bold()
                        .padding(.top, -8)
                }
                infoSection
                // TODO: Change image with place.image
                Image("indomaret")
                    .frame(height: 200)
                    .cornerRadius(8)
                detailSection
                // TODO: Add !isSameFloor condition
                accessSection
                Spacer()
                directionBtn
                    .padding(.bottom, 16)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var infoSection: some View {
        HStack{
            InfoItem(
                image: "mappin.and.ellipse",
                title: "Location",
                text: place.location.formattedFloorLevel())
            Spacer()
            // TODO: Create formatted place distance extension
            InfoItem(
                image: "location",
                title: "Distance",
                text: place.distance.distanceDesc)
            Spacer()
            HStack{
                Image(systemName: "info.circle")
                    .font(.system(size: 12))
                    .foregroundColor(.accentColor)
                    .background(
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("CircleColor")))
                VStack(alignment: .leading){
                    Text("Status")
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .systemGray))
                    Text(place.status.rawValue)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundColor(place.status.color)
                }
                .padding(.leading, 8)
            }
        }
        .padding(.horizontal)
    }

    var accessSection: some View {
        VStack(alignment: .leading) {
            Text("Access Option")
                .font(.callout)
                .fontWeight(.semibold)
            VStack(alignment: .center) {
                Text("Your current floor level is different. Please select the access option to reach the \(place.location.formattedFloorLevel()).")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(Color(uiColor: .systemGray))
                AccessOptPicker(selectedDetour: $selectedDetour)
                    .padding(.top, 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(uiColor: .systemGray6)))
            .fixedSize(horizontal: false, vertical: true)
        }
    }

    var detailSection: some View {
        VStack(alignment: .leading) {
            Text("Details")
                .font(.callout)
                .fontWeight(.semibold)
            VStack(alignment: .leading){
                Text("Operational Hours")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(Color(uiColor: .systemGray))
                // TODO: Replace the hardcoded data
                HStack{
                    Text("Everyday")
                    Spacer()
                    Text("10:00 AM - 09:00 PM")
                }
                .font(.callout)
                .fontWeight(.medium)
                .padding(.top, 2)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(uiColor: .systemGray6)))
        }
    }

    var directionBtn: some View {
        NavigationLink(destination: CompassView(targetPlace: place)) {
            Text("Start Direction")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("ComponentColor"))
                .cornerRadius(8)
        }
    }
}


struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView(place: Place.dummyPlace[0])
            .environmentObject(DiscoveryViewModel())
    }
}