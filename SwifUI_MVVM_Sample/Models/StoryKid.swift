//
//  StoryKid.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import Foundation

struct StoryKid: Identifiable, Codable {
    let id: Int
    let by: String
    let parent: Int
    let text: String
    let time: Int
    let type: String
}
