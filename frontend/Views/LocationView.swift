//
//  LocationView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import SwiftUI
import _MapKit_SwiftUI

struct LocationView: View {
    let location: Location?
    
    // Initialize the state variable with a closure
    @State private var locationPosition: MapCameraPosition = .automatic

        // Set up the camera position once the view has access to its properties
//        init(location: Location) {
//            self.location = location
//            self.locationPosition = .camera(
//                MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), distance: 980, heading: 242, pitch: 60)
//            )
//        }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                Text("Lorem Ipsum Title")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Subtitle
                Text("Lorem Ipsum")
                    .font(.title3)
                    .foregroundColor(.secondary)

                
                if let location = location {
                    Map(position: $locationPosition)
                        .frame(height: 200)
                        .cornerRadius(12)
                        .onAppear {
                            self.locationPosition = .camera(
                                MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon), distance: 500, heading: 0, pitch: 0)
                            )
                        }
                } else {
                    // Placeholder or loading view
                    Text("Loading map...")
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                }
                
                
                
                
                // Map displaying the location
                

                // Button Placeholder
                Button(action: {
                    // Action for button
                }) {
                    Text("Lorem Ipsum")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.bottom, 20)

                // Additional Info Section
                ForEach(0..<5) { _ in
                    VStack(alignment: .leading) {
                        Text("Lorem Ipsum Title")
                            .font(.headline)
                        Text("Lorem Ipsum Title")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Divider()
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    LocationView(location: LocationSwift(id: UUID(), latitude: 37.7749, longitude: -122.4194, name: "Haven's Coffee", priceRange: "$$", description: "Artisan coffee and pastries", locationType: .cafe))
//}
