//
//  Chats.swift
//  InvestUp
//
//  Created by Александр Гусев on 04.05.2023.
//

import SwiftUI

struct Chats: View {
    @ObservedObject var chatVM = ChatViewModel()
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Чаты")
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer()
                ScrollViewReader{ value in
                    ScrollView{
                        VStack{
                            ForEach(chatVM.chats) { item in
                                NavigationLink{
                                    ChatDetailView(chatId: item.id)
                                } label: {
                                    HStack{
                                        if(item.user.avatar == nil){
                                            Image("default")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                                .padding(.horizontal,10)
                                        }else{
                                            AsyncImage(url: URL(string: item.user.avatar!)){ image in
                                                image
                                                    .resizable()
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(Circle())
                                                    .padding(.horizontal,10)
                                            }placeholder: {
                                                Circle()
                                                    .foregroundColor(.gray.opacity(0.3))
                                                    .frame(width: 30, height: 30)
                                                    .clipShape(Circle())
                                                    .padding(.horizontal,10)
                                            }
                                            
                                        }
                                        VStack{
                                            HStack{
                                                Text("\(item.user.firstName) \(item.user.lastName)")
                                                    .padding(.trailing,3)
                                                Text("\(item.lastMessage.updatedAt.components(separatedBy: "T")[1].components(separatedBy: ".").first!)")
                                                    .font(.system(size: 9))
                                                Spacer()
                                            }
                                            HStack{
                                                Text("\(item.lastMessage.text)")
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
                        }
                    }
                    
                
                }
                
            }
            .onAppear(perform: chatVM.getChatsFetcher)
            
        }
        
        
    }
}

//struct Chats_Previews: PreviewProvider {
//    static var previews: some View {
//        Chats()
//    }
//}
