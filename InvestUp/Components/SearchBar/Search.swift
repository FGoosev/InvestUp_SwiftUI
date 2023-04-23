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
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .padding(.leading, 5)
                TextField("Найти", text: $search)
            }
            .frame(height: 35)
            .background(Color.gray.opacity(0.2))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
            .padding(.bottom, 10)
            .padding(.top, 10)
        }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(search: .constant(""))
    }
}
