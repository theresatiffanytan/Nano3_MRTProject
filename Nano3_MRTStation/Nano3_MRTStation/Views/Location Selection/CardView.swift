//
//  CardView.swift
//  Nano3_MRTStation
//
//  Created by Randy Julian on 19/07/23.
//

import SwiftUI

struct CardView: View {
    var body: some View {
//        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 358, height: 107)
                    .foregroundColor(Color("Grey"))
                
                HStack {
                    Image("2")
                        .resizable()
                        .frame(width: 110, height: 80)
                        .scaledToFit()
                        .cornerRadius(8)
                        .padding(.leading, 15)
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Indomaret Point")
                            .fontWeight(.bold)
                            .font(.system(size: 16))
                            .padding(.bottom, 1)
                            .padding(.top, 15)
                        
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 14))
                                .foregroundColor(.green)
                            Text("1st Floor")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                            
                            Image(systemName: "location.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.blue)
                                .padding(.leading, 10)
                            Text("100 m")
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .frame(maxHeight: 107)
                    .padding(.leading, -40)
                    Spacer()
                }
            }
//        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
