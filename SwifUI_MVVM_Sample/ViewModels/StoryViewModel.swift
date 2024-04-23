//
//  StoryViewModel.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 22/04/2024.
//

import Foundation
import Alamofire
import Combine

class StoryViewModel: ObservableObject {
    @Published var stories = [Story]()
    @Published private(set) var state = PageState.idle
    
    enum PageState {
        case idle
        case loading
        case failed(ErrorType)
        case loaded
    }
    
    private let storyApi = StoryApi()
    private var subscriptions: Set<AnyCancellable> = []

    // Alamofire, Combine
    func fetchTopStories() {
        state = .loading
        storyApi.getStories()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.receiveError(error: error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] ids in
                guard let self = self else { return }
                let group = DispatchGroup()
                var stories = [Story]()
                for id in ids.prefix(10) {
                    group.enter()
                    self.storyApi.getStory(id: id)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                self.receiveError(error: error)
                            case .finished:
                                break
                            }
                        }, receiveValue: { story in
                            stories.append(story)
                            group.leave()
                        })
                        .store(in: &subscriptions)
                }
                
                group.notify(queue: DispatchQueue.main) {
                    self.stories = stories
                    self.state = .loaded
                }
            })
            .store(in: &subscriptions)

    }
    
    private func receiveError(error: AFError) {
        if let code = error.responseCode {
            self.state = .failed(.backend(code))
        }
        if error.isSessionTaskError {
            self.state = .failed(.noInternet)
        }
        if error.isResponseSerializationError {
            self.state = .failed(.decoding)
        }
    }
    
//    func fetchTopStories() async throws {
//        let url = URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let ids = try JSONDecoder().decode([Int].self, from: data)
//        try await withThrowingTaskGroup(of: Story.self, body: { group in
//            for id in ids.prefix(10) {
//                group.addTask(operation: {
//                    return try await self.fetchStory(id: id)
//                })
//            }
//            
//            var stories = [Story]()
//            for try await story in group {
//                stories.append(story)
//            }
//            
//            self.stories = stories
//        })
//    }
//    
//    func fetchStory(id: Int) async throws -> Story {
//        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        return try decoder.decode(Story.self, from: data)
//    }
}
