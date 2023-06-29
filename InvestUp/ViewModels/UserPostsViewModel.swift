//
//  UserPostsViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 05.05.2023.
//

import Foundation
import Combine

final class UserPostsViewModel: ObservableObject {
    @Published var posts: [PostModelResponse] = []
    @Published var user = UserModel(id: "", email: "", isConfirmedEmail: true, firstName: "", lastName: "", updatedAt: "", createdAt: "", avatar: "", status: "", roles: [])
    @Published var lstPost: [PostModelResponse] = []
    private var bag = Set<AnyCancellable>()
    
    func getPostsFetch(userId: String){
        let url = "http://45.9.43.5:5000/posts/user/\(userId)"
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
    func mapList(){
        for post in posts{
            self.lstPost.append(PostModelResponse(id: post.id, title: post.title, videoUrl: post.videoUrl, status: post.status, description: post.description, updatedAt: post.updatedAt, createdAt: post.createdAt, views: post.views, favoriteCount: post.favoriteCount, shortDescription: post.shortDescription, user: post.user, tags: post.tags, isFavorite: post.isFavorite))
        }
    }
    
    func getInfoUser(userId: String){
        let url = "http://45.9.43.5:5000/users/\(userId)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: UserModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] user in
                    self?.user = user
                }
                .store(in: &bag)
            
        }
    }
}
