//
//  SurveyView.swift
//  frontend
//
//  Created by Clare Wilson on 11/19/23.
//

import SwiftUI

struct SurveyResult {
    var busy: Int
    var noisy: Int
    var comfy: Int
    var wifi: Int
    var parking: Int
    // var timestamp: Timestamp
    // var location : String
}

struct SurveyView : View{
    let location: Location?
    
    @State private var surveyResult = SurveyResult(busy: -1, noisy: -1, comfy: -1, wifi: -1, parking: -1)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Header
                Text("How's the Spot?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // Subtitle
                Text("Help other Spot users by answering a few questions about \(location!.name).")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                let qualities : [String] = ["busy", "noisy", "comfy"]
                ForEach(qualities.indices, id: \.self) { index in
                    Text("How \(qualities[index]) is it?").font(.title3)
                    HStack{
                        Button(action: {
                            //TODO: update surveyResult, change color, make sure not multiple are selected
                        }) {
                            Text(":(")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            //TODO: update surveyResult, change color, make sure not multiple are selected
                        }) {
                            Text(":|")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            //TODO: update surveyResult, change color, make sure not multiple are selected
                        }) {
                            Text(":)")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    Divider()
                }
                Button(action: {
                    //TODO: BACKEND TINGS, but smth like POST(surveyResult), no?
                }) {
                    Text("Submit")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
                    .padding()

            }
        }
    
    }
