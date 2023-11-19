//
//  frontendApp.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/17/23.
//

import SwiftUI

@main
struct frontendApp: App {
    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        start()
//        return true
//    }
//    
//    func start() async {
//                do {
//                    print("Initializing gRPC client...")
//                    try await LocationServiceProvder().beginListening()
//                }
//                catch {
//                    print("Failed to initialize gRPC client: \(error)")
//                    // Implement additional error handling as needed
//                }
//        }
//    }
//}

