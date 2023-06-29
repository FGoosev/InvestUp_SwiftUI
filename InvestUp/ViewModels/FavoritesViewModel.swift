//
//  FavoritesViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 09.05.2023.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject{
    @Published var posts: [PostModelResponse] = []
    private var bag = Set<AnyCancellable>()
    
    
    func getFavoritesFetch(){
        let url = "http://45.9.43.5:5000/posts/favorites"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
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
    
    func addFavoriteFetch(id: String){
        let url = "http://45.9.43.5:5000/posts/favorite/\(id)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: FavoriteResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] message in
                    print(message)
                }
                .store(in: &bag)
        }
    }
    
    func removeFavoriteFetch(id: String){
        let url = "http://45.9.43.5:5000/posts/unfavorite/\(id)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: FavoriteResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] message in
                    print(message)
                }
                .store(in: &bag)
        }
    }
    
    func searchPosts(searchQuery: String, tags: [String]){
        var url = "http://45.9.43.5:5000/posts/favorites?search=\(searchQuery)"
        for item in tags{
            url = "\(url)&tags[]=\(item)"
        }
        var encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
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
