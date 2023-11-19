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
    var timestamp: Date
    var place : String
}

struct SurveyView : View{
    @Environment(\.dismiss) var dismiss
    let location: Location?
    
    @State private var surveyResult = SurveyResult(busy: -1, noisy: -1, comfy: -1, wifi: -1, parking: -1, timestamp: Date(), place: "")
    
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
                
                
                
                let qualities : [String] = ["busyness", "noise level", "comfort level", "wifi quality", "parking"]
                ForEach(qualities.indices, id: \.self) { index in
                    Text("How is the: \(qualities[index])?").font(.title3)
                    HStack{
                        Button(action: {
                            //TODO: change color
                            updateSurveyResult(quality: qualities[index], with: 0)
                            
                        }) {
                            Text(":(")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            //TODO: change color
                            updateSurveyResult(quality: qualities[index], with: 1)
                        }) {
                            Text(":|")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            //TODO: change color
                            updateSurveyResult(quality: qualities[index], with: 2)
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
                    surveyResult.timestamp = Date()
                    surveyResult.place = location!.name
                    print(surveyResult)
                    dismiss()
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
    func updateSurveyResult(quality: String, with rating: Int){
        if(quality == "busyness"){
            surveyResult.busy = rating
        } else if (quality == "noise level"){
            surveyResult.noisy = rating
        } else if (quality == "comfort level"){
            surveyResult.comfy = rating
        } else if (quality == "wifi quality"){
            surveyResult.wifi = rating
        } else if (quality == "parking"){
            surveyResult.parking = rating
        }
    }
    
    //TODO: do this
    func toggleButtonColor (button: String){
        
    }
}
