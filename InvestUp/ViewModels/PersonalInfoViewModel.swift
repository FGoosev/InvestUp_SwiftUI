//
//  PersonalInfoViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import Foundation
import Combine

final class PersonalInfoViewModel: ObservableObject{
    @Published var user = UserModel(id: "", email: "", isConfirmedEmail: true, firstName: "", lastName: "", roles: [])
    init(){
        getInfoUser()
    }
    func getInfoUser(){
        
        guard let url = URL(string: "http://45.9.43.5:5000/users/me") else{
            return
        }
        guard let accessToken = LocalStorage.current.token else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let email = response?["email"] as? String ?? ""
                self.user.email = response?["email"] as? String ?? ""
                self.user.firstName = response?["firstName"] as? String ?? ""
                self.user.lastName = response?["lastName"] as? String ?? ""
            
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
