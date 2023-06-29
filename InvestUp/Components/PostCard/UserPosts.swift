//
//  UserPosts.swift
//  InvestUp
//
//  Created by Александр Гусев on 04.05.2023.
//

import SwiftUI

struct UserPosts: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var title: String = ""
    @State var description: String = ""
    @State var date: String = ""
    @State var tags: [TagServer] = []

    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
            }
            .padding(.horizontal,15)
            .padding(.top,15)
            HStack{
                Text("Опубликовано: " + date.components(separatedBy: "T").first!)
                    .font(.system(size: 13))
                Spacer()
            }
            .padding(.horizontal,15)
            
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(tags, id: \.id) { item in
                        HStack{
                            Text(item.value)
                                .foregroundColor(.white)
                                .font(.system(size: 13))
                                .padding(.horizontal,10)
                                .frame(height: 30)
                                .background(Color.green)
                                .clipShape(Capsule())
                        }
                        .padding(.horizontal, 5)
                        
                    }
                }
            }
            .padding(.horizontal, 7)
            Spacer()
            HStack{
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.bottom, 20)
            Spacer()
            
            
        }
        .frame(minWidth: 300, maxWidth: 400, minHeight: 275, maxHeight: 300)
        .background()
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 10)
    }
}

//struct UserPosts_Previews: PreviewProvider {
//    static var previews: some View {
//        UserPosts(firstName: "Александр",
//                  lastName: "Гусев",
//                  title: "Дизайн в SwiftUI",
//                  titleTag: "IT Технологии",
//                  description: "Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации.",
//                  date: "Опубликовано 21 апреля", handler: ())
//    }
//}
