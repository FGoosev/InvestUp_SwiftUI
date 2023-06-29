//
//  MainViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 01.05.2023.
//

import Foundation
import SwiftUI
import Combine


final class MainViewModel: ObservableObject{
    @Published var posts: [PostModelResponse] = []
    @Published var isRefreshing: Bool = false
    @Published var tags: [TagServer] = []
    private var bag = Set<AnyCancellable>()
    init(){
        getPostsFetch()
        getTagsFetch()
    }
    
    func getPostsFetch(){
        let url = "http://45.9.43.5:5000/posts"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            isRefreshing = true
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap({ res in
                    guard let response = res.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else{
                        LocalStorage.current.token = ""
                        LocalStorage.current.status = false
                        UserDefaults.standard.removeObject(forKey: "status")
                        AppManager.Auth.send(false)
                        return []
                    }
                    
                    let decoder = JSONDecoder()
                    guard let posts = try? decoder.decode([PostModelResponse].self, from: res.data) else{
                        return []
                    }
                    
                    return posts
                    
                })
                .sink{ res in
                    defer {self.isRefreshing = false}
                    
                    switch res{
                    case.failure(let error):
                        CustomError.failed
                    
                    default: break
                    }
                
                } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }
                .store(in: &bag)
            
        }
    }
    func getTagsFetch(){
        let url = "http://45.9.43.5:5000/tags"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: [TagServer].self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] tags in
                    self?.tags = tags
                }
                .store(in: &bag)
        }
    }
    func searchPosts(searchQuery: String, tags: [String]){
        var urlString = "http://45.9.43.5:5000/posts?search=\(searchQuery.utf8)"
        for item in tags{
            urlString = "\(urlString)&tags[]=\(item)"
        }
        var encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: encodedUrl ?? ""){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: [PostModelResponse].self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] posts in
                    self?.posts = posts
                }
                .store(in: &bag)
            
        }
    }
}

extension MainViewModel{
    enum CustomError: LocalizedError{
        case failed
        var errorDescription: String?{
            switch self{
                case .failed:
                    return "Failed"
            }
        }
    }
}
