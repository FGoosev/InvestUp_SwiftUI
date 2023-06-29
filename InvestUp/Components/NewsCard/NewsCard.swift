//
//  NewsCard.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import SwiftUI

struct NewsCard: View {
    @State var title: String
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Image("time")
                        .resizable()
                        .clipShape(Capsule())
                        .frame(width: 50,height: 50)
                        .padding(.top, 15)
                        .padding(.leading, 10)
                    Spacer()
                        
                }
                Spacer()
                HStack{
                    Text(title)
                        .font(.system(size: 15, weight: .medium))
                        .padding(.leading, 7)
                    Spacer()
                }
                Spacer()
                HStack{
                    Text("Посмотреть")
                        .font(.system(size: 15))
                        .foregroundColor(.green)
                        .padding(.leading, 7)
                        .padding(.bottom, 7)
                        
                    Spacer()
                }
                
            }
            .frame(width: 150, height: 150)
            .background()
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            
        }
        
    }
}

struct NewsCard_Previews: PreviewProvider {
    static var previews: some View {
        NewsCard(title: "Какую работу найти?")
    }
}
