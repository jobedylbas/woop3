//
//  Event.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import Foundation

struct Event: Codable {
    var date: Int
    var description: String
    var image: String
    var longitude: Float
    var latitude: Float
    var title: String
    var id: String
    var price: Double
}
