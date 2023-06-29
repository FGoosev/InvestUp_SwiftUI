//
//  UserPostsView.swift
//  InvestUp
//
//  Created by Александр Гусев on 04.05.2023.
//

import SwiftUI

struct UserPostsView: View {
    @ObservedObject var viewModel = UserPostsViewModel()
    @ObservedObject var vm = FavoritesViewModel()
    @State var userId : String = ""
    @State private var posts: [String] = []
    @State private var userPosts: [PostModelResponse] = []
    @State private var isShowingDialog = false
    @State private var text = ""
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                //Пользователь
                HStack{
                    if(viewModel.user.avatar == ""){
                        Image("default")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 70)
                            .padding()
                    }else{
                        AsyncImage(url: URL(string: viewModel.user.avatar ?? "")){ image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 60, height: 70)
                                .padding()
                        }placeholder: {
                            Circle()
                                .foregroundColor(.gray.opacity(0.3))
                                .frame(width: 70)
                                .padding()
                        }
                            
                    }
                }
                HStack{
                    Text("\(viewModel.user.firstName) \(viewModel.user.lastName)")
                        .font(.system(size: 25, weight: .semibold))
                }
                HStack{
                    
                    NavigationLink{
                        NewDialogView(userId: viewModel.user.id, userImage: viewModel.user.avatar ?? "", firstName: viewModel.user.firstName, lastName: viewModel.user.lastName)
                    }label: {
                        Text("Написать")
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 30)
                            .background(.green)
                            .clipShape(Capsule())
                    }
                    NavigationLink{
                        CreateReportView(userId: viewModel.user.id, userImage: viewModel.user.avatar ?? "", firstName: viewModel.user.firstName, lastName: viewModel.user.lastName, type: true)
                    }label: {
                        Text("Пожаловаться")
                            .foregroundColor(.white)
                            .fontWeight(.regular)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 30)
                            .background(.red)
                            .clipShape(Capsule())
                    }
                
                }
                HStack{
                    Text("Посты пользователя")
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Spacer()
                }
                VStack{
                    ForEach(viewModel.posts) { item in
                        NavigationLink {
                            PostDetailView(Id: item.id)
                        } label: {
                            ZStack{
                                PostCart(firstName: item.user.firstName,
                                         lastName: item.user.lastName,
                                    title: item.title,
                                         description: item.shortDescription,
                                         date: item.updatedAt,
                                         tags: item.tags,imageUrl: item.user.avatar ?? "",views: item.views, favoriteCount: item.favoriteCount)
                                
                                VStack{
                                    Spacer()
                                    HStack{
                                        Button(action: {
                                            if item.isFavorite{
                                                
                                                vm.removeFavoriteFetch(id: item.id)
                                            }else{
                                                vm.addFavoriteFetch(id: item.id)
                                                
                                            }
                                            
                                        }){
                                            Text(item.isFavorite ? "Удалить из избранного" : "Добавить в избранное")
                                                .foregroundColor(.white)
                                                .fontWeight(.regular)
                                                .padding(.vertical, 7)
                                                .padding(.horizontal, 30)
                                                .background(item.isFavorite ? .orange : .green)
                                                .clipShape(Capsule())
                                        }
                                        .padding(.leading)
                                    }
                                }
                                .padding(10)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .onAppear{
            viewModel.getInfoUser(userId: userId)
            viewModel.getPostsFetch(userId: userId)
        }
        .padding(.bottom, 50)
    }
}

struct UserPostsView_Previews: PreviewProvider {
    static var previews: some View {
        UserPostsView()
    }
}
