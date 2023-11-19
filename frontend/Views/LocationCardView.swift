//
//  LocationCardView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import SwiftUI

struct LocationCardView: View {
    let location: Location
    @State private var isShowingDetail = false

    var body: some View {
        Button(action: {
            isShowingDetail = true
        }) {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(.black)
                if let description = location.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text(location.priceRange)
                        .foregroundColor(.purple)
                    if(location.wifi != -1){
                        ((location.wifi)! == 1 ? ((location.freeWifi)! == 1 ? Image(systemName: "wifi") : Image("wifi.paid")) : Image(systemName: "wifi.slash")).foregroundStyle(.purple)
                    }
                    if(location.busyness != -1){
                        Image(systemName: "person.3.sequence.fill", variableValue: (Double(((location.busyness)!))+0.2)/2.0).foregroundStyle(.purple)
                    }
                    if(location.noise != -1) {
                        Image(systemName: "speaker.wave.3.fill",variableValue: (Double(((location.noise)!))+0.2)/2.0).foregroundStyle(.purple)
                    }
                    if(location.comfort != -1){
                        Image("sofa.scale",variableValue: (Double(((location.comfort)!))+0.2)/2.0).foregroundStyle(.purple)
                    }
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .sheet(isPresented: $isShowingDetail) {
            LocationView(location: location)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct LocationsScrollView: View {
    let locations: [Location]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(locations) { location in
                    LocationCardView(location: location)
                }
            }
            .padding()
        }
    }
}

let locations = [
        Location(id: "cL0q9S4bqwpbAN9ZKh-Zeg", latitude: 37.77216, longitude: -122.43086, name: "Nara Restaurant & Sake Bar", priceRange: "$$", description: "Japanese restaurant", locationType: .cafe, wifi: 1, freeWifi: 0, busyness: 1, comfort: 1, noise: 0),
        Location(id: "MmF102nQp2Tr1s0-zYni_A", latitude: 37.800992, longitude: -122.2701305, name: "Shooting Star Cafe", priceRange: "$$", description: "Chinese cafe serving bubble tea", locationType: .cafe, wifi: 1, freeWifi: 1, busyness: 0, comfort: 2, noise: 0),
        Location(id: "oCpJB_GNLvVsZ2YP8wu2GA", latitude: 37.783098, longitude: -122.461591, name: "Palmetto", priceRange: "$", description: "Modern spot serving acai bowls", locationType: .cafe, wifi: 1, freeWifi: 1, busyness: -1, comfort: -1, noise: -1),
    ]

#Preview {
    LocationsScrollView(locations: locations)
}
