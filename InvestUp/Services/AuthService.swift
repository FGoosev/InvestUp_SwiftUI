//
//  AuthService.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import Foundation
import Combine

struct AuthService {
    
    static var shared = AuthService()
    
    var status: CurrentValueSubject<Bool, Never>
    private init(){
        self.status = CurrentValueSubject<Bool, Never>(LocalStorage.current.status ?? false)
    }
    
}
