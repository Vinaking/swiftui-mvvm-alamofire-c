//
//  ContentView.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 22/04/2024.
//

import SwiftUI

struct StoryView: View {
    @ObservedObject private var viewModel = StoryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading, .idle:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error)
                case .loaded:
                    List (viewModel.stories) { story in
                        NavigationLink {
                            StoryKidView(storyId: story.id)
                        } label: {
                            StoryCell(story: story)
                        }
                    }
                    .listStyle(.plain)                
                }
            }
            .navigationTitle("News")
            .task {
                viewModel.fetchTopStories()
            }
        }
    }
}

#Preview {
    StoryView()
}
