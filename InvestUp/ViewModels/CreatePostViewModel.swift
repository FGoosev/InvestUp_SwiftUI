//
//  CreatePostViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 26.04.2023.
//

import Foundation
import Combine
import SwiftUI

final class CreatePostViewModel: ObservableObject{
    @Published var requestModel = PostModel(title: "", description: "", shortDescription: "", video: "", tags: [])
    @Published var tags: [TagServer] = []
    @Published var videoUrl: URL?
    @Published var data: Data = Data()
    @Published var responseModel: CreatePostResponse = CreatePostResponse(success: false, videoUrl: "", id: "")

    private var bag = Set<AnyCancellable>()
    
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
    func createPostFetch(){
        let url = "http://45.9.43.5:5000/posts/create"
        let boundary = UUID().uuidString
        var data1 = NSData(contentsOf: videoUrl! as URL)
        var d: Data = Data(referencing: data1! as NSData)
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var dataBody = Data()

            
            dataBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            dataBody.append("Content-Disposition: form-data; name=\"title\"\r\n".data(using: .utf8)!)
            dataBody.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            dataBody.append(requestModel.title)
            dataBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            
            dataBody.append("Content-Disposition: form-data; name=\"description\"\r\n".data(using: .utf8)!)
            dataBody.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            dataBody.append(requestModel.description)
            dataBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)

            dataBody.append("Content-Disposition: form-data; name=\"shortDescription\"\r\n".data(using: .utf8)!)
            dataBody.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            dataBody.append(requestModel.shortDescription)
            dataBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            
            dataBody.append("Content-Disposition: form-data; name=\"tags\"\r\n".data(using: .utf8)!)
            dataBody.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            dataBody.append("\(requestModel.tags)")
            dataBody.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            
            dataBody.append("Content-Disposition: form-data; name=\"video\"; filename=\"videoPicker.mov\"\r\n".data(using: .utf8)!)
            dataBody.append("Content-Type: video/quicktime\r\n\r\n".data(using: .utf8)!)
            dataBody.append(d)
            dataBody.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = dataBody
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: CreatePostResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] resp in
                    self?.responseModel = resp
                    
                    
                }
                .store(in: &bag)
        }
    }
}
