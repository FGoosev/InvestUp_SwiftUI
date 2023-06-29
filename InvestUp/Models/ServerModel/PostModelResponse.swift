//
//  PostModelResponse.swift
//  InvestUp
//
//  Created by Александр Гусев on 30.04.2023.
//

import Foundation


struct PostModelResponse: Codable,Identifiable{
    
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
    var isFavorite: Bool
}
