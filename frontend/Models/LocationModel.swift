//
//  LocationModel.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/18/23.
//

import Foundation

struct Location: Identifiable {
    let id: String
    let latitude: Double
    let longitude: Double
    let name: String
    let priceRange: String
    let description: String?
    let locationType: LocationType?
    var metadata: [String: String]?
    //clare's adds<3
    var wifi: Int? //should be 0-1
    var freeWifi: Int? // should be 0-1
    var busyness: Int? //should be 0-2
    var comfort: Int? //should be 0-2
    var noise: Int? //should be 0-2

    enum LocationType: String {
        case cafe
        case library
        case office
        case park
    }
}
