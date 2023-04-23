//
//  PostCart.swift
//  InvestUp
//
//  Created by Александр Гусев on 21.04.2023.
//

import SwiftUI

struct PostCart: View {
    @State var title: String = ""
    @State var titleTag: String = ""
    @State var description: String = ""
    @State var date: String = ""
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack{
                    HStack{
                        Text(title)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.leading, 10)
                        
                        Spacer()
                        Image(systemName: "heart.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 25, height: 25)
                    }
                    HStack{
                        VStack{
                            HStack{
                                
                                TagButton(title: titleTag)
                                
                                Spacer()
                            }
                            
                            Spacer()
                            HStack{
                                Text(description)
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            Spacer()
                            
                            HStack{
                                Text(date)
                                    .font(.system(size: 15, weight: .medium))
                                    .padding(.leading, 10)
                                Spacer()
                            }
                        }
                        VStack{
                            Image("original")
                                .resizable()
                                .cornerRadius(25)
                                .frame(width: 130, height: 200)
                        }
                    }
                    
                }
                .padding(10)
                Spacer()
            }
        }
        .frame(minWidth: 300, maxWidth: 400, minHeight: 275, maxHeight: 300)
        .background(Color("lightGray"))
        .cornerRadius(15)
        .padding(.horizontal, 10)
        
    }
    
}
struct PostCart_Previews: PreviewProvider {
    static var previews: some View {
        PostCart(title: "Дизайн в SwiftUI",
                 titleTag: "IT Технологии",
                 description: "Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации.",
                 date: "Опубликовано 21 апреля")
    }
}
