//
//  StoryCell.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 22/04/2024.
//

import SwiftUI

struct StoryCell: View {
    let title: String
    let footnote: String
    let score: Int
    let commentCount: Int
    
    init(story: Story) {
        title = story.title
        score = story.score
        commentCount = story.commentCount
        footnote = (story.url.path)
        + " - \(story.date.formatted(.relative(presentation: .numeric)))"
        + " - by \(story.author)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(title)
                .font(.headline)
            Text(footnote)
                .font(.footnote)
                .foregroundColor(.secondary)
            HStack(alignment: .top, spacing: 32) {
                Label(score.formatted(), systemImage: "arrowtriangle.up.circle")
                    .foregroundStyle(.blue)
                    .frame(width: 80, alignment: .leading)
                Label(commentCount.formatted(), systemImage: "ellipses.bubble")
                    .foregroundStyle(.orange)
                    .frame(width: 80, alignment: .leading)
            }
            .font(.footnote)
            .labelStyle(.titleAndIcon)
        }
    }
}

#Preview {
    StoryCell(story: Story(
        id: 1,
        commentCount: 111,
        score: 123,
        author: "vinaking",
        title: "If buying isn't owning, piracy isn't stealing",
        date: Date(),
        url: URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!,
        kids: [1,2,3]
    ))
}
