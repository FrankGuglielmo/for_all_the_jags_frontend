//
//  ContentView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/17/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Coordinates for San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .frame(height: 300)
            
            TextField("Search Locations...", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(0..<5) { _ in
                        DestinationBlock()
                    }
                }
                .padding()
            }
        }
    }
}

struct DestinationBlock: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lorem Ipsum")
                .font(.headline)
            Text("Simply dummy text of the printing")
                .font(.subheadline)
            HStack {
                ForEach(0..<3) { _ in
                    Text("lorum")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            Text("25 - 30K")
                .font(.caption)
                .padding(.vertical)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
