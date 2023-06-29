//
//  UpdatePostViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 16.05.2023.
//

import Foundation
import Combine

final class UpdatePostViewModel: ObservableObject{
    @Published var post: PostModelResponse = PostModelResponse(id: "", title: "", videoUrl: "", status: "", description: "", updatedAt: "", createdAt: "", views: 0, favoriteCount: 0, shortDescription: "", user: UserModel(id: "", email: "", isConfirmedEmail: false, firstName: "", lastName: "", updatedAt: "", createdAt: "", avatar: "", status: "", roles: []), tags: [], isFavorite: false)
    private var bag = Set<AnyCancellable>()

    var tagsString: [String] = []
    
    func updatePostFetcher(id: String, requestModel: UpdatePostRequest){
        for tag in requestModel.tags{
            tagsString.append(tag.id)
        }
        let url = "http://45.9.43.5:5000/posts/\(id)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "PUT"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            let body: [String: AnyHashable] = [
                "title": requestModel.title,
                "description": requestModel.description,
                "shortDescription": requestModel.shortDescription,
                "tags": tagsString
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: PostModelResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] post in
                    self?.post = post
                }
                .store(in: &bag)
            
        }
    }
}
