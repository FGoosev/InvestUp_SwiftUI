//
//  CreatePostResponse.swift
//  InvestUp
//
//  Created by Александр Гусев on 01.05.2023.
//

import Foundation


struct CreatePostResponse: Codable{
    var success: Bool
    var videoUrl: String
    var id: String
}
