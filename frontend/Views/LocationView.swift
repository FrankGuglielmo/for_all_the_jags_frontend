//
//  LocationView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import SwiftUI
import _MapKit_SwiftUI

struct Attribute {
    var icon: AnyView
    var title: String
    var description: String
    var showInfoButton: Bool
}

struct LocationView: View {
    let location: Location?
    
    // Initialize the state variable with a closure
    @State private var locationPosition: MapCameraPosition = .automatic
    
    @State private var isTimerRunning = false
    @State private var showAlert = false
    @State private var isShowingPopover: Bool = false

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
                Text(location!.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Subtitle
                Text((location!.description)!)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                //TODO: call API to pull hour info?
                //TODO: show distance?
                
                
                /* make a navigationable link / maps api / button
                 - lock view / distance, etc.
                 */
                if let location = location {
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                    Button(action:{
                        let mapUrl = URL(string: "maps://?saddr=&daddr=\(location.latitude),\(location.longitude)")
                        UIApplication.shared.open(mapUrl!)
                    }) {
                        Map(position: $locationPosition) {
                            Marker(location.name,systemImage: "pawprint.fill" , coordinate: coordinate)
                                .tint(.purple)
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                        .onAppear {
                            self.locationPosition = .camera(
                                MapCamera(centerCoordinate: coordinate, distance: 500, heading: 0, pitch: 0)
                            )
                        }}
                } else {
                    // Placeholder or loading view
                    Text("Loading map...")
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                }
                
                
                // Button Placeholder
                Button(action: {
                    startTimer()
                }) {
                    Text("I'm Here")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("How's the Spot?"),
                                message: Text("Let us know in a survey! This would be a sheet instead methinks."),
                                dismissButton: .default(Text("OK").foregroundColor(.indigo))
                            )
                        }

                .padding(.bottom, 20)
                
                let quality: [String] = ["not very", "pretty", "super"]
                
                let busyAttribute = Attribute(icon: AnyView(Image(systemName: "person.3.sequence.fill", variableValue: (Double(((location?.busyness)!))+0.2)/2.0)), title: "Busyness", description: "It's \(quality[(location?.busyness!)!]) busy", showInfoButton: true)
                
                let noiseAttribute = Attribute(icon: AnyView(Image(systemName: "speaker.wave.3.fill",variableValue: (Double(((location?.noise)!))+0.2)/2.0)), title: "Noise Level", description: "It's \(quality[(location?.noise!)!]) noisy", showInfoButton: true)
                
                let comfyAttribute = Attribute(icon: AnyView(Image("sofa.scale",variableValue: (Double(((location?.comfort)!))+0.2)/2.0)), title: "Comfort", description: "It's \(quality[(location?.comfort!)!]) comfy", showInfoButton: true)
                
                let priceQuality = if(location!.priceRange == "Free") {"nothing"} else if(location!.priceRange == "$") {"a little"} else if(location!.priceRange == "$$"){"a moderate amount"} else if(location!.priceRange == "$$$") {"a significant amount"} else{"a whole lot"}
                let priceAttribute : Attribute = Attribute(icon: AnyView(Text(location!.priceRange)), title:"Price Range", description: "People typically spend \(priceQuality) here", showInfoButton: false )
                
                let wifiCost = ((location?.wifi)! ? ((location?.freeWifi)! ? "free" : "paid") : "no")
                let wifiImage = ((location?.wifi)! ? ((location?.freeWifi)! ? Image(systemName: "wifi") : Image("wifi.paid")) : Image(systemName: "wifi.slash"))
                let wifiAttribute :Attribute = Attribute(icon: AnyView(wifiImage), title: "Wifi Access", description: "There is \(wifiCost) wifi here", showInfoButton: false )
                
                let attributes: [Attribute] = [
                    priceAttribute, wifiAttribute, busyAttribute, noiseAttribute, comfyAttribute
                ]
                
                ForEach(attributes, id: \.title) { attr in
                    VStack(alignment: .leading) {
                        HStack(content: {
                            attr.icon.symbolRenderingMode(.palette)
                                .foregroundStyle(.purple)
                                .font(.headline)
                            Text(attr.title)
                                .font(.headline)
                            // TODO: Add "i" button if showInfoButton is true
                            /*
                            if(attr.showInfoButton){
                                Button {
                                                    self.isShowingPopover.toggle()
                                                } label: {
                                                    Image(systemName: "info.circle")
                                                        .foregroundColor(.indigo)
                                                        .font(.system(size: 14))  // Adjust the font size
                                                }
                                                .popover(isPresented: $isShowingPopover) {
                                                    VStack {
                                                        Text("Additional Information")
                                                            .font(.headline)
                                                            .padding()
                                                        Text("As reported by other Spot users.")
                                                            .padding()
                                                    }
                                                    .frame(width: 200, height: 100) // Adjust size as needed
                                                }
                                                .buttonStyle(PlainButtonStyle())  // Remove button styling
                                
                            }
                             */
                        })
                        
                        Text(attr.description)
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
    
    func startTimer() {
           // Reset state
           isTimerRunning = false
           showAlert = false

           // Start the timer
            // TODO: would be 10 minutes or smth
            //TODO: make valid outside view// view model?
           Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { timer in
               // Timer callback
               isTimerRunning = false
               showAlert = true
           }

           // Update state
           isTimerRunning = true
       }
    
}

#Preview {
    LocationView(location: Location(id: UUID(), latitude: 37.7749, longitude: -122.4194, name: "Haven's Coffee", priceRange: "$$", description: "Artisan coffee and pastries", locationType: .cafe, wifi: true, freeWifi: false, busyness: 2, comfort: 3, noise: 1))
}
