//
//  DialogModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 28.05.2023.
//

import Foundation


struct DialogModel: Codable{
    var id: String
    var users: [UserCommentModel]
    var messages: [MessageModel]
}
