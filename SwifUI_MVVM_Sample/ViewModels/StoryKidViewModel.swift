//
//  StoryKidViewModel.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import Foundation
import Alamofire

class StoryKidViewModel: ObservableObject {
    @Published var storyKids = [StoryKid]()

    func fetchStory(id: Int, complement: @escaping ((Story?)->())) {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        AF.request(url).responseDecodable(of: Story.self) { response in
            switch response.result {
            case .success(let story):
                complement(story)
            case .failure(let error):
                complement(nil)
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchStoryKids(id: Int) {
        let group = DispatchGroup()
        var storyKids = [StoryKid]()
        fetchStory(id: id) { story in
            if let story = story {
                for kid in story.kids.prefix(10) {
                    group.enter()
                    self.fetchStoryKid(id: kid) { kid in
                        if let kid = kid {
                            storyKids.append(kid)
                            group.leave()
                        }
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                self.storyKids = storyKids
            }
        }
    }
    
    func fetchStoryKid(id: Int, complement: @escaping ((StoryKid?)->())) {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        fetchStory(id: id) { story in
            AF.request(url).responseDecodable(of: StoryKid.self) { response in
                switch response.result {
                case .success(let storyKid):
                    complement(storyKid)
                case .failure(let error):
                    complement(nil)
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
    }
}
