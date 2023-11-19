//
//  SurveyView.swift
//  frontend
//
//  Created by Clare Wilson on 11/19/23.
//

import SwiftUI

//struct SurveyResult {
//    var busy: Int
//    var noisy: Int
//    var comfy: Int
//    var wifi: Int
//    var parking: Int
//    var timestamp: Date
//    var place : String
//}

struct SurveyResult: Codable {
    var busy_level: Int
    var comfort_level: Int
    var wifi_situation: Int
    var noise_level: Int
    var parking_situation: Int
    var timestamp: Date
    var location: String
}




struct SurveyView : View{
    @Environment(\.dismiss) var dismiss
    let location: Location?
    
    @State private var busyRating: Int = -1
    @State private var noiseRating: Int = -1
    @State private var comfortRating: Int = -1
    @State private var wifiRating: Int = -1
    @State private var parkingRating: Int = -1
    
    @State private var surveyResult = SurveyResult(
        busy_level: -1,
        comfort_level: -1,
        wifi_situation: -1,
        noise_level: -1,
        parking_situation: -1,
        timestamp: Date(),
        location: "" // This will be set when the survey is submitted
    )


    
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
                    HStack{
                        VStack{
                            HStack{
                                Text("How's the \(qualities[index])?").font(.title3)
                                Text(rating(for: qualities[index])).font(.title3).foregroundColor(.purple)
                            }
                            HStack{
                                Button(action: {
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
                        }
                    }
                    Divider()
                }
                Button(action: {
                    surveyResult.timestamp = Date()
                    surveyResult.location = location?.id ?? ""
                        submitSurvey()
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
    
    func submitSurvey() {
           guard let locationId = location?.id else { return }
           print("LOCATION ID: \(locationId)" )

           guard let url = URL(string: "http://localhost:8000/surveys/") else {
               print("Invalid URL")
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           let encoder = JSONEncoder()
           
           // Custom date formatter
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
           dateFormatter.locale = Locale(identifier: "en_US_POSIX") // POSIX locale to ensure consistent formatting
           dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC timezone
           encoder.dateEncodingStrategy = .formatted(dateFormatter)

           guard let jsonData = try? encoder.encode(surveyResult) else {
               print("Failed to encode survey data")
               return
           }

           let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
               if let error = error {
                   print("Error submitting survey: \(error)")
                   return
               }
               if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                   print("Survey submitted successfully")
               } else {
                   print("Failed to submit survey")
               }
           }
           task.resume()
       }


    
    func updateSurveyResult(quality: String, with rating: Int){
        if(quality == "busyness"){
            surveyResult.busy_level = rating
            busyRating = rating;
        } else if (quality == "noise level"){
            surveyResult.noise_level = rating
            noiseRating = rating;
        } else if (quality == "comfort level"){
            surveyResult.comfort_level = rating
            comfortRating = rating;
        } else if (quality == "wifi quality"){
            surveyResult.wifi_situation = rating
            wifiRating = rating;
        } else if (quality == "parking"){
            surveyResult.parking_situation = rating
            parkingRating = rating;
        }
    }
    
    func rating(for quality: String) -> String {
            switch quality {
            case "busyness":
                return ratingText(for: busyRating)
            case "noise level":
                return ratingText(for: noiseRating)
            case "comfort level":
                return ratingText(for: comfortRating)
            case "wifi quality":
                return ratingText(for: wifiRating)
            case "parking":
                return ratingText(for: parkingRating)
            default:
                return ""
            }
        }

        func ratingText(for rating: Int) -> String {
            switch rating {
            case 0:
                return ":("
            case 1:
                return ":|"
            case 2:
                return ":)"
            default:
                return ""
            }
        }
}
