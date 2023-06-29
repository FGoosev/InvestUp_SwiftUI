//
//  UserCommentModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 10.05.2023.
//

import Foundation


struct UserCommentModel: Codable{
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String?
}
