//
//  ApiTest.swift
//  InvestUp
//
//  Created by Александр Гусев on 20.04.2023.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject{
    @Published var loginModel = RequestLoginModel(email: "", password: "")
//    var login: RequestLoginModel
//    init(log: RequestLoginModel){
//        login = log
//    }
    func login(){
        guard let url = URL(string: "http://45.9.43.5:5000/auth/login") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "email": loginModel.email,
            "password": loginModel.password
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
                
        let task = URLSession.shared.dataTask(with: request){ [weak self] data, _, error in
            DispatchQueue.main.async{
                guard let data = data, error == nil else{
                    return
                }
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    let accessToken = response?["accessToken"] as? String ?? ""
                    if(accessToken == ""){
                        print("Вы ввели неверные данные!")
                        LocalStorage.current.status = false
                    }else{
                        LocalStorage.current.token = accessToken
                        LocalStorage.current.status = true
                        AppManager.Auth.send(true)
                    }
                    
                
                }catch{
                    print(error)
                }
            }
            
        }
        task.resume()
    }
}



