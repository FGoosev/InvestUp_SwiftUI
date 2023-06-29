//
//  ChatCard.swift
//  InvestUp
//
//  Created by Александр Гусев on 04.05.2023.
//

import SwiftUI

struct ChatCard: View {
    var body: some View {
        HStack{
            Image("default")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.horizontal,10)
            VStack{
                HStack{
                    Text("Александр Гусев")
                    Spacer()
                }
                HStack{
                    Text("Привет мир!")
                        .font(.system(size: 13))
                    Spacer()
                }
            }
            Spacer()
        }
        .frame(minWidth: 300, maxWidth: 400, minHeight: 50, maxHeight: 60)
        .background()
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 10)
        
    }
}

struct ChatMessage: View{
    var body: some View{
        ScrollView{
            VStack{
                HStack{
                    Text("item.textgfdsgfdgsdgfdsgsfgsgsgsdgfsdgsdfgsdgdfdfgdsgsdgsgsgsgsgsdgsdfgsdgsdgdsfgsdgdfsgsdgdsgsgsgfsgsgsgfsgsgs")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                    Text("17:37")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        
                }
//                HStack{
//                    Spacer()
//                    Text("17:37")
//                        .foregroundColor(.white)
//                        .font(.system(size: 13))
//                }
            }
            .padding(.horizontal,10)
            .frame(minHeight: 30)
            .background(Color.blue)
            .padding(.trailing,10)
            .cornerRadius(10)
            
        }
        
    }
}

struct ChatCard_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessage()
    }
}
