//
//  ChatModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import Foundation


struct ChatModel: Codable, Identifiable{
    var id: String
    var user: UserCommentModel
    var unreadableMessages: Int
    var lastMessage: MessageModel
}
