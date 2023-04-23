//
//  RegistrationViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import Foundation
import Combine

final class RegistrationViewModel: ObservableObject{
    @Published var model = RequestRegisterModel(firstName: "", lastName: "", email: "", password: "")
    
    func register(){
        guard let url = URL(string: "http://45.9.43.5:5000/auth/registration") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: AnyHashable] = [
            "email": model.email,
            "firstName": model.firstName,
            "lastName": model.lastName,
            "password": model.password,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let accessToken = response?["accessToken"] as? String ?? ""
                if(accessToken == ""){
                    print("Данные введены некорректно")
                }else{
                    LocalStorage.current.token = accessToken
                    LocalStorage.current.status = true
                    AppManager.Auth.send(true)
                }
                
            
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
