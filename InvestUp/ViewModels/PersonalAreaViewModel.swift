//
//  PersonalAreaViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import Foundation

class PersonalAreaViewModel:ObservableObject{
    func logoutUser() {
        LocalStorage.current.token = ""
        LocalStorage.current.status = false
        UserDefaults.standard.removeObject(forKey: "status")
        AppManager.Auth.send(false)
    }
}

