//
//  ReportModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 07.06.2023.
//

import Foundation


struct ReportModel: Codable{
    var id: String
    var text: String
    var author: UserCommentModel
    var status: String
    var type: String
    var updatedAt: String
    var createdAt: String
    var post: PostFromReport
}

struct PostFromReport: Codable{
    var id: String
    var title: String
}

struct ReportUserModel: Codable{
    var id: String
    var text: String
    var author: UserCommentModel
    var status: String
    var type: String
    var updatedAt: String
    var createdAt: String
    var user: UserCommentModel
}
