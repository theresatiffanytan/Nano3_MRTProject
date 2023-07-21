//
//  PlaceDetailsView.swift
//  Nano3_MRTStation
//
//  Created by Fernando Putra on 21/07/23.
//

import SwiftUI

struct PlaceDetailsView: View {
    @State var isPressed = false
    let alertTitle: String = "A Short Alert Title"
    let isSameFloor: Bool
    let targetPlace: Place
    @Binding var detourPreference: Services?
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(targetPlace.category.rawValue)
                        .font(.system(size: 14))
                        .foregroundColor(Color("TitleColor"))
                    Text(targetPlace.name)
                        .font(.system(size: 22, weight: .bold))
                }
                Spacer()
            }
            //            .padding(.vertical)

            HStack{
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 12))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Location")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text(targetPlace.location.formattedFloorLevel())
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.leading, 8)
                }
                Spacer()
                HStack{
                    Image(systemName: "location")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Distance")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text("\(targetPlace.location.getDistance()) m")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .padding(.leading, 8)
                }
                Spacer()
                HStack{
                    Image(systemName: "info.circle")
                        .font(.system(size: 14))
                        .foregroundColor(Color("ComponentColor"))
                        .background(Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("CircleColor")))
                    VStack(alignment: .leading){
                        Text("Status")
                            .font(.system(size: 12))
                            .foregroundColor(Color("DetailColor"))
                        Text(targetPlace.status.rawValue)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 8)
                }
            }
            .padding(.bottom, 15)
            .padding(.leading, 10)

            Image("indomaret")
                .frame(height: 202)
                .cornerRadius(8)

            HStack {
                Text("Details")
                    .font(.system(size: 14, weight: .medium))
                Spacer()
            }
            .padding(.top, 20)

            VStack(alignment: .leading){
                Text("Operational Hours")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color("DetailColor"))
                HStack{
                    Text("Everyday")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                    Text("10.00PM - 09.00AM")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.black)
            }
            .padding()
            .frame(width: 358, height: 59)
            .background(Color("FrameColor"))
            .cornerRadius(8)

            Spacer()

            Group{
                HStack {
                    Text("Which route do you want to take?")
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                }

                HStack{
                    Button {
                        detourPreference = .Escalator
                    } label: {
                        Image(detourPreference == .Escalator ? "escalatorpick" : "escalator")
                            .resizable()
                            .frame(width: 86, height: 54)
                            .padding()
                    }

                    Button {
                        detourPreference = .Elevator
                    } label: {
                        Image(detourPreference == .Elevator ? "liftpick" : "lift")
                            .resizable()
                            .frame(width: 86, height: 54)
                            .padding()
                    }

                    Button {
                        detourPreference = .Staircase
                    } label: {
                        Image(detourPreference == .Staircase ? "stairpick" : "stair")
                            .resizable()
                            .frame(width: 86, height: 54)
                            .padding()
                    }
                }.padding()
                    .frame(width: 352, height: 70)
                    .background(Color("FrameColor"))
                    .cornerRadius(8)

            }
            .opacity(isSameFloor ? 0 : 1)

            Spacer()

            Button {
                isPressed = true
            } label: {
                Text("Direction")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 358, height: 44)
                    .background(Color("ComponentColor"))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 20)
        .alert(alertTitle, isPresented: Binding(get: { !isSameFloor && isPressed },
                                                set: { _,_ in })){
            VStack{
                Button(getStringValue(from: Services.Staircase)){
                    setDetourPreference(to: Services.Staircase)
                    isPressed = false
                }
                Button(getStringValue(from: Services.Escalator)){
                    setDetourPreference(to: Services.Escalator)
                    isPressed = false
                }
                Button(getStringValue(from: Services.Elevator)){
                    setDetourPreference(to: Services.Elevator)
                    isPressed = false
                }
            }
        }
    }
    func getStringValue(from service: Services) -> String {
        return service.rawValue
    }
    func setDetourPreference(to preference: Services) -> () {
        detourPreference = preference
    }
    func backButtonView() -> some View {
        return Button {
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.black)
        }
    }
}


struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView(isSameFloor: true, targetPlace: Place.dummyPlace[0], detourPreference: .constant(.Escalator))
    }
}
