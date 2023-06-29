//
//  PostDetailView.swift
//  InvestUp
//
//  Created by Александр Гусев on 02.05.2023.
//

import SwiftUI
import AVKit

struct PostDetailView: View {
    @ObservedObject var viewModel = PostDetailViewModel()
    @ObservedObject var userModel = PersonalInfoViewModel()
    @State var Id: String = ""
    @State private var player : AVPlayer?
    @State var comment: String = ""
    @State var url: URL = URL(string: "http://45.9.43.5:5000/videos/622f681a-803b-4042-bbb7-64110cdef1ad.6446c1a0db985af29c7d6bdc.MOV")!
    @State private var isShowingDialog = false
    @State private var idComment: String = ""
    var body: some View {
        ZStack{
            VStack{
                ScrollView{
                    VStack{
                        HStack{
                            if(viewModel.post.user.avatar == ""){
                                Image("default")
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 40, height: 40)
                            }else{
                                AsyncImage(url: URL(string: viewModel.post.user.avatar!)){ image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
                                }placeholder: {
                                    Circle()
                                        .foregroundColor(.gray.opacity(0.3))
                                        .clipShape(Circle())
                                        .frame(width: 40, height: 40)
                                }
                                
                            }
                            Text(viewModel.post.user.firstName + " " +  viewModel.post.user.lastName)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        
                        HStack{
                            Text(viewModel.post.title)
                                .font(.system(size: 30, weight: .bold))
                            Spacer()
                        }
                        .padding()
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(viewModel.post.tags, id: \.id) { item in
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
                        
                        HStack{
                            Text(viewModel.post.description)
                                .padding()
                        }
                        HStack{
                            VideoPlayer(player: AVPlayer(url: URL(string: viewModel.post.videoUrl) ?? url))
                                .onAppear(){
                                    guard let url = URL(string: viewModel.post.videoUrl) else{
                                        return
                                    }
                                    let player = AVPlayer(url: url)
                                    player.seek(to: .zero)
                                    player.play()
                                }
                                .onDisappear(){
                                    player?.pause()
                                }
                            
                            
                        }
                        .frame(height: 300)
                        .padding()
                        if(userModel.user.id != viewModel.post.user.id){
                            HStack{
                                NavigationLink{
                                    CreateReportView(userId: viewModel.post.user.id, userImage: viewModel.post.user.avatar ?? "", firstName: viewModel.post.user.firstName, lastName: viewModel.post.user.lastName, postId: viewModel.post.id, type: false)
                                } label: {
                                    Text("Пожаловаться")
                                        .foregroundColor(.white)
                                        .fontWeight(.regular)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 30)
                                        .background(.red)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        
                        Divider()
                        HStack{
                            Text("Комментарии")
                                .padding(.leading, 15)
                            Spacer()
                        }
                        HStack{
                            TextField("Оставить комментарий", text: $comment)
                            Button(action:{
                                viewModel.createCommentFetcher(postId: viewModel.post.id, text: comment)
                                comment = ""
                                
                            }){
                                Text("Отправить")
                                
                            }
                        }
                        .padding()
                        ForEach(viewModel.post.comments, id: \.id) { item in
                            HStack{
                                VStack{
                                    HStack{
                                        if(item.user.avatar == nil){
                                            Image("default")
                                                .resizable()
                                                .clipShape(Circle())
                                                .frame(width: 40, height: 40)
                                        }else{
                                            AsyncImage(url: URL(string: item.user.avatar!)){ image in
                                                image
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 40, height: 40)
                                            }placeholder: {
                                                Circle()
                                                    .foregroundColor(.gray.opacity(0.3))
                                                    .clipShape(Circle())
                                                    .frame(width: 40, height: 40)
                                            }
                                            
                                        }
                                        Text(item.user.firstName + " " +  item.user.lastName)
                                            .font(.system(size: 20, weight: .semibold))
                                        Spacer()
                                    }
                                    HStack{
                                        Text(item.text)
                                        Spacer()
                                    }
                                }
                                if userModel.user.id == item.user.id{
                                    Button(action: {
                                        self.idComment = item.id
                                        
                                        isShowingDialog = true
                                    }){
                                        Text("Удалить")
                                    }
                                    .confirmationDialog("Вы действительно хотите удалить запись?", isPresented: $isShowingDialog, titleVisibility: .visible){
                                        Button("Подтвердить", role: .destructive){
                                            viewModel.deleteCommentFetcher(id: self.idComment)
                                            viewModel.post.comments.removeAll(where: {$0.id == self.idComment})
                                        }
                                        Button("Отменить", role: .cancel){
                                            
                                        }
                                    }
                                }
                                
                            }
                            .padding(.vertical, 7)
                            .padding(.horizontal, 15)
                            Divider()
                        }
                        
                        
                    }
                }
                .padding(.bottom,50)
                .onAppear(perform: {
                    viewModel.getPostByIdFetcher(postId: Id)
                })
            }
            
        }
    }
}

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView(, post: <#Binding<PostModelResponse>#>)
//    }
//}
