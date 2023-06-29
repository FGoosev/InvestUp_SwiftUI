//
//  ChatDetailModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import Foundation

struct ChatDetailModel: Codable{
    var id: String
    var users: [UserCommentModel]
    var messages: [MessageModel]
}
