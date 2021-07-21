//
//  Radio.swift
//  CarPlayTutorial
//
//  Created by Jordan Montel on 14/07/2021.
//

import Foundation

struct Radio: Decodable {
    let uid: String
    let title: String
    let subtitle: String
    let desc: String
    let imageUrl: String
    let imageSquareUrl: String
    let audioUrl: String
    let linkUrl: String
    let wikipediaUrl: String
}
