//
//  LocationModel.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import Foundation

struct Location: Identifiable {
    let id: UUID
    let latitude: Double
    let longitude: Double
    let name: String
    let priceRange: String
    let description: String?
    let locationType: LocationType?
    var metadata: [String: String]?

    enum LocationType: String {
        case cafe
        case library
        case office
        case park
    }
}
