//
//  PersonalPost.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct PersonalPost: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack{
                    HStack{
                        Text("Дизайн в SwiftUI")
                            .font(.system(size: 25, weight: .bold))
                            
                        Spacer()
                        
                    }
                    HStack{
                        ScrollView{
                            ForEach(0 ..< 5) { item in
                                TagButton(title: "IT Технологии")
                            }
                        }
                        
                    }
                    .padding(.bottom, 25)
                    
                    Spacer()
                    HStack{
                        Text("Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации.")
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                    }
                    Spacer()
                    
                    HStack{
                        Text("21 апреля 2023")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.leading, 10)
                        Spacer()
                    }
                }
                .padding(10)
                Spacer()
                VStack{
                    Image("original")
                        .resizable()
                }
            }
        }
        .frame(minWidth: 300, maxWidth: 350, minHeight: 275, maxHeight: 300)
        .shadow(color: Color(.brown).opacity(0.3), radius: 20, x: 0, y: 10)
        .background(Color("lightGray"))
        .cornerRadius(25)
            
    }
}

struct PersonalPost_Previews: PreviewProvider {
    static var previews: some View {
        PersonalPost()
    }
}
