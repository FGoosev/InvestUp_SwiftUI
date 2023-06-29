//
//  PersonalInfoViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import Foundation
import SwiftUI
import Combine

final class PersonalInfoViewModel: ObservableObject{
    @Published var user = UserModel(id: "", email: "", isConfirmedEmail: true, firstName: "", lastName: "", updatedAt: "", createdAt: "", avatar: "", status: "", roles: [])
    @Published var passwordRequest = UpdatePersonalInfoRequest(password: "", newPassword: "")
    private var changeAvatarResponse = ChangeAvatarResponse(message: "", url: "")
    @Published var myPosts: [PostModelResponse] = []
    private var bag = Set<AnyCancellable>()

    init(){
        getInfoUserFetch()
        getMyPostFetcher()
    }
    
    func logoutUserFetch(){
        let url = "http://45.9.43.5:5000/auth/logout"
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
                    
                } receiveValue: { [weak self] tags in
                    
                }
                .store(in: &bag)
        }
        LocalStorage.current.token = ""
        LocalStorage.current.status = false
        UserDefaults.standard.removeObject(forKey: "status")
        AppManager.Auth.send(false)
    }
    
    func getInfoUserFetch(){
        let url = "http://45.9.43.5:5000/users/me"
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
    
    func updateInfoFetch(){
        let url = "http://45.9.43.5:5000/users/change/info"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            let body: [String: AnyHashable] = [
                "firstName": user.firstName,
                "lastName": user.lastName
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: ChangeInfoResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] changeInfo in
                    self?.user = changeInfo.user

                }
                .store(in: &bag)
        }
    }
    
    func changePasswordFetcher(){
        let url = "http://45.9.43.5:5000/users/change/password"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            let body: [String: AnyHashable] = [
                "password": passwordRequest.password,
                "newPassword": passwordRequest.newPassword
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: FavoriteResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] changeInfo in
                    print(changeInfo)
                }
                .store(in: &bag)
        }
    }
    
    func changeAvatarFetcher(paramName: String, fileName: String, image: UIImage){
        let url = "http://45.9.43.5:5000/users/avatar"
        let boundary = UUID().uuidString
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            guard let accessToken = LocalStorage.current.token else { return }
            let imageData = image.jpegData(compressionQuality: 0.5)
            request.httpMethod = "POST"
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var data = Data()
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(imageData!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = data
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: ChangePhotoResponse.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] changeInfo in
                    self?.user.avatar = changeInfo.url
                }
                .store(in: &bag)
        }
    }
    
    func getMyPostFetcher(){
        let url = "http://45.9.43.5:5000/posts/me"
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
                    self?.myPosts = posts
                }
                .store(in: &bag)
        }
    }
    
    func removePostFetcher(id: String){
        let url = "http://45.9.43.5:5000/posts/\(id)"
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
                    
                } receiveValue: { [weak self] changeInfo in
                    print(changeInfo)
                }
                .store(in: &bag)
        }
    }
    
}

extension Data {
    mutating func append(_ string: String){
        if let data = string.data(using: .utf8){
            self.append(data)
        }
    }
}
