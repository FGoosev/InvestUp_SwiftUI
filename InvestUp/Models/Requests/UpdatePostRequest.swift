//
//  UpdatePostRequest.swift
//  InvestUp
//
//  Created by Александр Гусев on 16.05.2023.
//

import Foundation


struct UpdatePostRequest: Codable{
    var title: String
    var description: String
    var shortDescription: String
    var tags: [TagServer]
}
