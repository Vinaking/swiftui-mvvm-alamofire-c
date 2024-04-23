//
//  Story.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 22/04/2024.
//

import Foundation

struct Story: Identifiable {
    let id: Int
    let commentCount: Int
    let score: Int
    let author: String
    let title: String
    let date: Date
    let url: URL
    let kids: [Int]
}

extension Story: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, score, title, url, kids
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
        
    }
}
