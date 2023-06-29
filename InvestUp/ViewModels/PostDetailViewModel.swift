//
//  PostDetailViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 02.05.2023.
//

import Foundation
import Combine

final class PostDetailViewModel: ObservableObject {
    @Published var post = PostDetailModel(id: "", title: "", videoUrl: "", status: "", description: "", updatedAt: "", createdAt: "", views: 0,favoriteCount: 0, shortDescription: "", user: UserModel(id: "", email: "", isConfirmedEmail: false, firstName: "", lastName: "", updatedAt: "", createdAt: "", avatar: "", status: "", roles: []),tags: [], commentsCount: 0, comments: [])
    @Published var comment = CommentModel(id: "", text: "", updatedAt: "", createdAt: "", user: UserCommentModel(id: "", email: "", firstName: "", lastName: "", avatar: ""))
    @Published var tags: [TagServer] = []
    
    private var bag = Set<AnyCancellable>()
    
    func checkLists(){
        for tag in tags {
            if post.tags.contains(tag){
                
            }
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
    
    func getPostByIdFetcher(postId: String){
        let url = "http://45.9.43.5:5000/posts/\(postId)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: PostDetailModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] post in
                    self?.post = post
                }
                .store(in: &bag)
            
        }
    }
    
    func createCommentFetcher(postId: String, text: String){
        let url = "http://45.9.43.5:5000/posts/comment"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            let body: [String: AnyHashable] = [
                "postId": postId,
                "text": text
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: CommentModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] comment in
                    self?.comment = comment
                    self?.post.comments.insert(self?.comment ?? CommentModel(id: "", text: "", updatedAt: "", createdAt: "", user: UserCommentModel(id: "", email: "", firstName: "", lastName: "", avatar: "")), at: 0)
                }
                .store(in: &bag)
            
        }
    }
    
    func deleteCommentFetcher(id: String){
        let url = "http://45.9.43.5:5000/posts/comment/\(id)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "DELETE"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: FavoriteResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] resp in
                    print(resp)
                }
                .store(in: &bag)
            
        }
    }
}
