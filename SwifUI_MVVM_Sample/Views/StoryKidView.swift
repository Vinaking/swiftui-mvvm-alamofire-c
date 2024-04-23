//
//  StoryKidView.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import SwiftUI

struct StoryKidView: View {
    @ObservedObject var viewModel = StoryKidViewModel()
    var storyId: Int
    var body: some View {
        List (viewModel.storyKids) { kid in
            StoryKidCell(storyKid: kid)
                .onTapGesture {
                    print("by: \(kid.by)")
                }
        }
        .listStyle(.plain)
        .navigationTitle("Kids")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.fetchStoryKids(id: storyId)
        }
    }
}

#Preview {
    StoryKidView(storyId: 40077533)
}
