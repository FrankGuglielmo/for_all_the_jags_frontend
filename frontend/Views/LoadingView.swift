//
//  LoadingView.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress = 0.0
    @State private var isLoadingComplete = false
    
    var body: some View {
        Group {
            if isLoadingComplete {
                ContentView()
            } else {
                VStack {
                    Image("spot-logo") // Replace "spot-logo" with your actual image asset name
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("Spot") // The name of your app
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .kerning(2.5)
                        .padding(.bottom, 20)
                    
                    // Progress bar
                    ProgressView(value: progress, total: 100)
                        .accentColor(.purple) // This changes the tint color of the progress bar
                        .frame(width: 200)
                        .progressViewStyle(LinearProgressViewStyle())
                        .onAppear {
                            // Simulate progress
                            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                self.progress += 2
                                if self.progress >= 100 {
                                    timer.invalidate()
                                    self.isLoadingComplete = true // Trigger the transition to ContentView
                                }
                            }
                        }
                }
            }
        }
    
    }
}

#Preview {
    LoadingView()
}
