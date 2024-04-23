//
//  StoryApi.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import Foundation
import Combine
import Alamofire

protocol StoryApiProtocol {
    func getStories() -> AnyPublisher<[Int], AFError>
    func getStory(id: Int) -> AnyPublisher<Story, AFError>
}

struct StoryApi: StoryApiProtocol {
    func getStories() -> AnyPublisher<[Int], Alamofire.AFError> {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")!
        
        let parameters = [
            "": ""
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        return AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .publishDecodable(type: [Int].self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
    func getStory(id: Int) -> AnyPublisher<Story, Alamofire.AFError> {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: Story.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
