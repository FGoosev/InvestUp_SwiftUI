//
//  ChatDetailView.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var chatVM = ChatViewModel()
    @ObservedObject var infoVM = PersonalInfoViewModel()
    @State var mess = ""
    @State var chatId: String = ""
    var body: some View {
        ScrollViewReader{value in
            ScrollView{
                VStack{
                    ForEach(chatVM.chatById.messages){ item in
                        HStack{
                            if(item.user.id == infoVM.user.id){
                                Spacer()
                                Text(item.text)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13))
                                    .padding(.horizontal,10)
                                    .frame(minHeight: 30)
                                    .background(Color.blue)
                                    .padding(.trailing,10)
                                    .cornerRadius(10)
                            }else{
                                Text(item.text)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13))
                                    .padding(.horizontal,10)
                                    .padding(.vertical,5)
                                    .frame(minHeight: 30)
                                    .background(Color.green)
                                    .padding(.leading,10)
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        Divider()
                    }
                    
                }
                
            }
            .onAppear(perform: {
                
                chatVM.getChatDetailFetcher(id: chatId)
                infoVM.getInfoUserFetch()
                
            })
        }
        
        Spacer()
        HStack{
            TextField("Написать",text: $mess)
            Button(action:{
                chatVM.sendMessage(text: mess, dialogId: chatVM.chatById.id, user: UserCommentModel(id: infoVM.user.id, email: infoVM.user.email, firstName: infoVM.user.firstName, lastName: infoVM.user.lastName, avatar: infoVM.user.avatar))
                mess = ""
            }){
                Image(systemName: "greaterthan.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    
            }
            
        }
        .padding(.horizontal,10)
        .padding(.bottom, 60)
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailView()
    }
}
