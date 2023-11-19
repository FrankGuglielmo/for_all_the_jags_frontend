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
                    ((location.wifi)! ? ((location.freeWifi)! ? Image(systemName: "wifi") : Image("wifi.paid")) : Image(systemName: "wifi.slash")).foregroundStyle(.purple)
                    Image(systemName: "person.3.sequence.fill", variableValue: (Double(((location.busyness)!))+0.2)/2.0).foregroundStyle(.purple)
                    Image(systemName: "speaker.wave.3.fill",variableValue: (Double(((location.noise)!))+0.2)/2.0).foregroundStyle(.purple)
                    Image("sofa.scale",variableValue: (Double(((location.comfort)!))+0.2)/2.0).foregroundStyle(.purple)
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
        Location(id: UUID(), latitude: 37.7749, longitude: -122.4194, name: "Haven's Coffee", priceRange: "$$", description: "Artisan coffee and pastries", locationType: .cafe, wifi: true, freeWifi: false, busyness: 1, comfort: 2, noise: 0),
        Location(id: UUID(), latitude: 51.5074, longitude: -0.1278, name: "Grand Library", priceRange: "Free", description: "Historic library with vast collections", locationType: .library, wifi: true, freeWifi: true, busyness: 0, comfort: 2, noise: 0),
        Location(id: UUID(), latitude: 40.7128, longitude: -74.0060, name: "TechSpace Office", priceRange: "$$$", description: "Modern coworking space", locationType: .office, wifi: true, freeWifi: false, busyness: 0, comfort: 0, noise: 1),
        Location(id: UUID(), latitude: 48.8566, longitude: 2.3522, name: "Champs Park", priceRange: "Free", description: "Expansive park with scenic views", locationType: .park, wifi: false, freeWifi: false, busyness: 2, comfort: 1, noise: 2),
        Location(id: UUID(), latitude: -33.8688, longitude: 151.2093, name: "Harbor Side Cafe", priceRange: "$$", description: "Cafe with a view of the harbor", locationType: .cafe, wifi: true, freeWifi: false, busyness: 1, comfort: 2, noise: 1)
    ]

#Preview {
    LocationsScrollView(locations: locations)
}
