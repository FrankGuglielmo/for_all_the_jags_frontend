//
//  ContentView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/17/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager: LocationManager = LocationManager()
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @State private var cardOffset: CGFloat = 0
    @State private var isCardExpanded: Bool = false
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Map(position: $position)
                        .edgesIgnoringSafeArea(.all)

                    ScrollViewReader { scrollView in
                        VStack {
                            TextField("Search Locations...", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            ScrollView {
                                VStack(alignment: .leading, spacing: 20) {
                                    ForEach(0..<20) { index in // Increased number for demonstration
                                        DestinationBlock()
                                            .id(index)
                                    }
                                }
                                .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .offset(y: isCardExpanded ? 0 : geometry.size.height - 150 + cardOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        let offset = gesture.translation.height
                                        if isCardExpanded || (!isCardExpanded && offset > 0) {
                                            self.cardOffset = offset
                                        }
                                    }
                                    .onEnded { _ in
                                        if self.cardOffset < -100 {
                                            self.isCardExpanded = true
                                            self.cardOffset = 0
                                            scrollView.scrollTo(0, anchor: .top)
                                        } else if isCardExpanded && cardOffset > 100 {
                                            self.isCardExpanded = false
                                            self.cardOffset = 0
                                        } else {
                                            self.cardOffset = 0
                                        }
                                    }
                            )
                        }
                        .onChange(of: isCardExpanded, in) { expanded in
                            if expanded {
                                scrollView.scrollTo(0, anchor: .top)
                            }
                        }
                    }
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
