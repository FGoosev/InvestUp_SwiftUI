//
//  CreatePostButton.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct CreatePostButton: View {
    @State var title: String
    var body: some View {
        HStack{
            Button(action: {
                
            }){
                
                Text("Создать новый пост")
            }
            .padding()
            .background(Color("lightGray"))
            .cornerRadius(15)
            .offset(y: 25)
        }
        
        
    }
}

struct CreatePostButton_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostButton(title: "Создать новый пост")
    }
}
