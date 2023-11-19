//
//  ContentView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/17/23.
//

import SwiftUI
import MapKit

enum CardState {
    case full, half, expanded
}

struct ContentView: View {
    @StateObject private var locationManager: LocationManager = LocationManager()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var cardOffset = CGSize.zero
    @State private var cardState: CardState = .half
    @State private var cardPresented = false // State to track whether the card is presented full screen or not

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    //Initialize the Map here
                    Map(position: $position){
                        UserAnnotation()
                    }
                    .mapControls {
                        MapUserLocationButton()
                    }
                    .frame(height: geometry.size.height / 2 + 30)
                    .contentMargins(27)
                    
                    Spacer()
                }
                
                // Initialize the Card View for all the Cards
                CardView()
                    .offset(y: cardPresented ? 50 : geometry.size.height / 2)
                    .animation(.spring(), value: cardPresented)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let yOffset = gesture.translation.height
                                // Only allow dragging upwards
                                if yOffset < 0 {
                                    self.cardOffset = CGSize(width: 0, height: max(yOffset, -geometry.size.height / 2))
                                }
                            }
                            .onEnded { _ in
                                if self.cardOffset.height < -geometry.size.height / 16 {
                                    // If dragged beyond the threshold, present the card full screen
                                    self.cardPresented = true
                                } else {
                                    // Snap back to the half-screen position
                                    self.cardPresented = false
                                }
                                self.cardOffset = .zero // Reset the drag offset
                            }
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
        }
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update the view.
    }
}

struct CardView: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.white)
            .frame(height: UIScreen.main.bounds.height)
            .shadow(radius: 10)
            .overlay(
                VStack {
                    GrabberHandle()
                    LocationsScrollView(locations: locations)
                }
            )
    }
}

struct GrabberHandle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 80, height: 10)
            .foregroundColor(.gray)
            .padding(5)
    }
}

#Preview {
    ContentView()
}
