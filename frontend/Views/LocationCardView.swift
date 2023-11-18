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
                Text(location.priceRange)
                    .foregroundColor(.green)
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
        Location(id: UUID(), latitude: 37.7749, longitude: -122.4194, name: "Haven's Coffee", priceRange: "$$", description: "Artisan coffee and pastries", locationType: .cafe),
        Location(id: UUID(), latitude: 51.5074, longitude: -0.1278, name: "Grand Library", priceRange: "Free", description: "Historic library with vast collections", locationType: .library),
        Location(id: UUID(), latitude: 40.7128, longitude: -74.0060, name: "TechSpace Office", priceRange: "$$$", description: "Modern coworking space", locationType: .office),
        Location(id: UUID(), latitude: 48.8566, longitude: 2.3522, name: "Champs Park", priceRange: "Free", description: "Expansive park with scenic views", locationType: .park),
        Location(id: UUID(), latitude: -33.8688, longitude: 151.2093, name: "Harbor Side Cafe", priceRange: "$$", description: "Cafe with a view of the harbor", locationType: .cafe)
    ]

#Preview {
    LocationsScrollView(locations: locations)
}
