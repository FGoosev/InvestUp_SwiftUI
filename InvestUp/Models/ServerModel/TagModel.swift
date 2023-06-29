//
//  TagModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import Foundation


struct TagModel: Codable, Identifiable,Equatable{
    var id =   UUID()
    var value: String
}

struct TagServer: Codable, Identifiable,Equatable{
    var id: String
    var value: String
}
