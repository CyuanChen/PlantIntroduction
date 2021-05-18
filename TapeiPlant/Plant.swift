//
//  Plant.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/10.
//

import Foundation
struct Plants: Codable {
    let result: Result
    
    struct Result: Codable {
        let results: [Plant]
    }
}

struct Plant: Codable {

    let name: String
    let location: String
    let feature: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "F_Name_Ch"
        case location = "F_Location"
        case feature = "F_Feature"
        case imageUrl = "F_Pic01_URL"
    }
}
