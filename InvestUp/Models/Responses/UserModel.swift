//
//  UserModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import Foundation


struct UserModel:Codable,Identifiable{
    var id: String
    var email: String
    var isConfirmedEmail: Bool
    var firstName: String
    var lastName: String
    var roles: [RoleModel]
}

struct RoleModel:Codable,Identifiable{
    var id: String
    var value: String
}
