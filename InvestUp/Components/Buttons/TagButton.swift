//
//  TagButton.swift
//  InvestUp
//
//  Created by Александр Гусев on 21.04.2023.
//

import SwiftUI

struct TagButton: View {
    @State var title: String
    var body: some View {
        Button(action: {
            
        }){
            Circle().frame(width: 10)
            Text(title)
        }
        .padding(.leading,10)
        .padding(.trailing,10)
        .padding(.top, 5)
        .padding(.bottom, 5)
        .background(Color("Color1"))
        .cornerRadius(25)
        .offset(y: 25)
    
    }
}

struct TagButton_Previews: PreviewProvider {
    static var previews: some View {
        TagButton(title: "IT Технологии")
    }
}
