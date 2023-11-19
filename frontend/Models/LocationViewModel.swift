//
//  LocationViewModel.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/19/23.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private var provider = LocationServiceProvder()
    
    private var cancellable: AnyCancellable?
    
    func fetchData() async {
        for await location in provider.beginListening() {
            self.locations.append(location)
        }
    }
    
}
