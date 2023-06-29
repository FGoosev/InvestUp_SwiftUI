//
//  PersonalPost.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct PersonalPost: View {
    @State var post: PostModelResponse = PostModelResponse(id: "", title: "", videoUrl: "", status: "", description: "", updatedAt: "Date.now", createdAt: "Date.now",views: 0,favoriteCount: 0, shortDescription: "", user: UserModel(id: "", email: "", isConfirmedEmail: false, firstName: "", lastName: "", updatedAt: "", createdAt: "", avatar: "", status: "", roles: []), tags: [],isFavorite: false)
    var body: some View {
        VStack{
            HStack(alignment: .top){
                VStack{
                    HStack{
                        Text(post.title)
                            .font(.system(size: 25, weight: .bold))
                            
                        Spacer()
                        
                    }
                    HStack{
                        ScrollView{
//                            ForEach(post.tags, id: \.id) { item in
//                                TagButton(title: item.value)
//                            }
                        }
                        
                    }
                    .padding(.bottom, 25)
                    
                    Spacer()
                    HStack{
                        Text(post.shortDescription)
                            .font(.system(size: 15, weight: .medium))
                        Spacer()
                    }
                    Spacer()
                    
                    HStack{
                        Text("\(post.updatedAt)")
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
        .frame(minWidth: 300, maxWidth: .infinity, minHeight: 275, maxHeight: 300)
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
