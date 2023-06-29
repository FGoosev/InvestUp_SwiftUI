//
//  PostCart.swift
//  InvestUp
//
//  Created by Александр Гусев on 21.04.2023.
//

import SwiftUI

struct PostCart: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var title: String = ""
    @State var titleTag: String = ""
    @State var description: String = ""
    @State var date: String = ""
    @State var tags: [TagServer] = []
    @State var imageUrl: String = ""
    @State var views: Int = 0
    @State var favoriteCount: Int = 0
    
    var body: some View {
        
        VStack{
            HStack{
                if(imageUrl == ""){
                    Image("default")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }else{
                    AsyncImage(url: URL(string: imageUrl)){ image in
                        image
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 35, height: 40)
                    }placeholder: {
                        Circle()
                            .foregroundColor(.gray.opacity(0.3))
                            .clipShape(Circle())
                            .frame(width: 35, height: 40)
                    }
                        
                }
                VStack{
                    HStack{
                        Text(firstName + " " + lastName)
                            .font(.system(size: 15, weight: .semibold))
                        Spacer()
                            
                    }
                    .padding(.horizontal, 5)
                    HStack{
                        Text("Опубликовано " + date.components(separatedBy: "T").first!)
                            .font(.system(size: 10, weight: .regular))
                        Spacer()
                    }
                    .padding(.horizontal, 5)
                }
                Spacer()
                
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 15)
            
            
            HStack{
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15, weight: .bold))
                    .padding(.leading, 10)
                
                Spacer()
                
        
            }
            .padding(.bottom, 5)
            
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
            .padding(.bottom,5)
            
            HStack{
                Text(description)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.leading, 10)
                Spacer()
            }
            .frame(height: 60)
            .padding(.bottom,30)
            Spacer()
            
            
        }
        .frame(minWidth: 300, maxWidth: 400, minHeight: 275, maxHeight: 300)
        .background()
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 10)
        
    }
    
}
struct PostCart_Previews: PreviewProvider {
    static var previews: some View {
        PostCart(firstName: "Александр",
                 lastName: "Гусев",
                 title: "Дизайн в SwiftUI очень большой проверяю",
                 titleTag: "IT Технологии",
                 description: "Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации.",
                 date: "Опубликовано 21 апреля")
    }
}
