//
//  Story.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import Foundation

struct Story: Decodable {
    let id: Int
    let userId: Int
    let pictureUrl: String
    //let date: Date
    var isLiked: Bool? = false
}
