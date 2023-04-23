//
//  ResponseAuthModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import Foundation

struct ResponseAuthModel: Codable{
    var accessToken: String
    var refreshToken: String
}
