//
//  MessageModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import Foundation

struct MessageModel: Codable,Identifiable{

    var id: String
    var text: String
    var dialogId: String
    var updatedAt: String
    var createdAt: String
    var read: Bool
    var user: UserCommentModel
}

struct MessageWSModel: Codable, Identifiable{
    var id: String
    var text: String
    var updatedAt: String
    var createdAt: String
    var read: Bool
    var user: UserCommentModel
    var dialogId: String
    var event: String
}
