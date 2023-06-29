//
//  PostDetailModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 10.05.2023.
//

import Foundation



struct PostDetailModel: Codable{
    var id: String
    var title: String
    var videoUrl: String
    var status: String
    var description: String
    var updatedAt: String
    var createdAt: String
    var views: Int
    var favoriteCount: Int
    var shortDescription: String
    var user: UserModel
    var tags: [TagServer]
    var commentsCount: Int
    var comments: [CommentModel]
}
