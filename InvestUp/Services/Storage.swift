//
//  Storage.swift
//  InvestUp
//
//  Created by Александр Гусев on 20.04.2023.
//

import Foundation

enum LocalStorageKey: String {
    case token
    case status
}

struct LocalStorage {
    
    private let userDefaults = UserDefaults.standard
    
    static var current = LocalStorage()
    
    private init(){}
    
    
    var token: String? {
        
        get {
            userDefaults.string(forKey: LocalStorageKey.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: LocalStorageKey.token.rawValue)
        }
    }
    var status: Bool? {
            
            get {
                userDefaults.bool(forKey: LocalStorageKey.status.rawValue)
            }
            
            set {
                userDefaults.set(newValue, forKey: LocalStorageKey.status.rawValue)
            }
            
        }
}
