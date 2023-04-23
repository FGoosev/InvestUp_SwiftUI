//
//  AppManager.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import Foundation
import Combine

struct AppManager{
    static let Auth = PassthroughSubject<Bool, Never>()
    static func IsAuth() -> Bool{
        return LocalStorage.current.status ?? false
    }
}
