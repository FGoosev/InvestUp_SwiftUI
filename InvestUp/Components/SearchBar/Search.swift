//
//  Search.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct Search: View {
    @Binding var search: String
        var body: some View {
           Text("Hello")
        }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(search: .constant(""))
    }
}

