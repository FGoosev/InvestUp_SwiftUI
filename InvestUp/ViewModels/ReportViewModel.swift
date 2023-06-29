//
//  ReportViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 07.06.2023.
//

import Foundation
import Combine


final class ReportViewModel: ObservableObject{
    @Published var reportResponse = ReportModel(id: "", text: "", author: UserCommentModel(id: "", email: "", firstName: "", lastName: "", avatar: ""), status: "", type: "", updatedAt: "", createdAt: "", post: PostFromReport(id: "", title: ""))
    @Published var reportUserResponse = ReportUserModel(id: "", text: "", author: UserCommentModel(id: "", email: "", firstName: "", lastName: "", avatar: ""), status: "", type: "", updatedAt: "", createdAt: "", user: UserCommentModel(id: "", email: "", firstName: "", lastName: "", avatar: ""))
    private var bag = Set<AnyCancellable>()
    func reportPostFetcher(postId: String, text: String){
        let url = "http://45.9.43.5:5000/complaints/post"
        let boundary = UUID().uuidString
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            guard let accessToken = LocalStorage.current.token else { return }
        
            request.httpMethod = "POST"
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            
            let body: [String: AnyHashable] = [
                "text": text,
                "postId":postId
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: ReportModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] report in
                    print(report)
                    self?.reportResponse = report
                }
                .store(in: &bag)
        }
    }
    func reportUserFetcher(userId: String, text: String){
        let url = "http://45.9.43.5:5000/complaints/user"
        let boundary = UUID().uuidString
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            guard let accessToken = LocalStorage.current.token else { return }
        
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            let body: [String: AnyHashable] = [
                "text": text,
                "userId":userId
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: ReportUserModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] report in
                    print(report)
                    self?.reportUserResponse = report
                }
                .store(in: &bag)
        }
    }
}
