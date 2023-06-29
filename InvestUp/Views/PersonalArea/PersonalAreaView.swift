//
//  PersonalAreaView.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct PersonalAreaView: View {
    @ObservedObject var vm = PersonalInfoViewModel()
    @ObservedObject var postDetailViewModel = PostDetailViewModel()
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var createPostVM = CreatePostViewModel()
    @State private var tagSelection: String? = nil
    @State private var isShowingDialog = false
    @State private var idPost: String = ""
    @Environment(\.refresh) private var refresh
        @State private var isLoading = false // 1
    let titles: [String] = ["Какую работу найти?", "Как устроено инвестирование", "Что такое стартап?"]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    if isLoading { // 2
                        ProgressView()
                    }
                    NavigationLink(destination: PersonalInfoView().environmentObject(vm), tag: "userDetail", selection: $tagSelection) { EmptyView() }
                    Button {
                        tagSelection = "userDetail"
                    } label: {
                        ZStack{
//                            PersonalCard(firstName: vm.user.firstName, lastName: vm.user.lastName, email: vm.user.email, imageUrl: vm.user.avatar == "" ? "" : vm.user.avatar)
                            VStack{
                                HStack{
                                    if(vm.user.avatar == nil){
                                        Image("default")
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 70)
                                            .padding()
                                    }else{
                                        AsyncImage(url: URL(string: vm.user.avatar!)){ image in
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
                                    VStack{
                                        HStack{
                                            Text("\(vm.user.firstName) \(vm.user.lastName)")
                                                .font(.system(size: 15, weight: .semibold))
                                                .padding(.leading, 25)
                                                .padding(.top, 25)
                                                .padding(.bottom, 15)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(vm.user.email)
                                                .font(.system(size: 13, weight: .medium))
                                                .padding(.leading, 25)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                
                                
                            }
                            .frame(width: .infinity, height: 100)
                            .background()
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                            
                            Spacer()
                            VStack{
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        vm.logoutUserFetch()
                                    }) {
                                        Text("Выйти")
                                            .font(.body)
                                    }
                                    .padding(.trailing,15)
                                }
                            }
                        }
                        
                    }
                    .padding(.vertical, 5)
                    
                }
                .background()
                .padding(.horizontal, 7)
                .cornerRadius(30)
                
                Spacer()
                HStack{
                    Text("Личные публикации")
                        .font(.system(size: 25, weight: .bold))
                        .padding()
                    Spacer()
                    Button(action:{
                        isLoading = true // 3
                        //refresh
                        vm.getMyPostFetcher()
                        isLoading = false
                    }){
                        Image(systemName: "arrow.uturn.right.circle")
                            .padding(.trailing, 15)
                    }
                    
                    NavigationLink{
                        CreatePostView().environmentObject(vm)
                    } label: {
                        Image(systemName: "plus")
                            .padding(.trailing, 15)
                    }
                
                }
                VStack{
                    if(vm.myPosts.count > 0){
                        ForEach(vm.myPosts, id: \.id) { post in
                            
                            
                            NavigationLink {
                                PostDetailView(Id: post.id)
                            } label: {
                                ZStack{
                                    PostCart(firstName: post.user.firstName,
                                             lastName: post.user.lastName,
                                        title: post.title,
                                             description: post.shortDescription,
                                             date: post.updatedAt,
                                             tags: post.tags,imageUrl: post.user.avatar ?? "",views: post.views, favoriteCount: post.favoriteCount)
                                    Spacer()
                                    VStack{
                                        HStack{
                                            Spacer()
                                            NavigationLink{
                                                UpdatePostView(postId: post.id)
                                            } label: {
                                                Image(systemName: "pencil")
                                            }
                                            .padding()
                                            Button(action: {
                                                self.idPost = post.id
                                                isShowingDialog = true
                                            }) {
                                                Image(systemName: "trash")
                                            }
                                            .confirmationDialog("Вы действительно хотите удалить запись?", isPresented: $isShowingDialog, titleVisibility: .visible){
                                                Button("Подтвердить", role: .destructive){
                                                    vm.removePostFetcher(id: idPost)
                                                    vm.myPosts.removeAll(where: {$0.id == idPost})
                                                }
                                                Button("Отменить", role: .cancel){
                                                    
                                                }
                                            }
                                            
                                        }
                                        Spacer()
                                    }
                                    .padding(20)
                                    VStack{
                                        Spacer()
                                        HStack{
                                            Image(systemName: "eye")
                                                .frame(width: 20)
                                            Text("\(post.views)")
                                            Image(systemName: "heart.circle")
                                                .frame(width: 20)
                                            Text("\(post.favoriteCount)")
                                            Spacer()
                                        }
                                        .padding(.leading,15)
                                        
                                    }.padding(15)
                                    
                                    
                                }
                                
                            }
                            .padding(.vertical, 5)
                            
                                
                        }
//                        List{
//                            ForEach(vm.myPosts, id: \.id) { post in
//
//
//                                NavigationLink {
//                                    PostDetailView(Id: post.id)
//                                } label: {
//                                    ZStack{
//                                        PostCart(firstName: post.user.firstName,
//                                                 lastName: post.user.lastName,
//                                            title: post.title,
//                                                 description: post.shortDescription,
//                                                 date: post.updatedAt,
//                                                 tags: post.tags,imageUrl: post.user.avatar ?? "",views: post.views, favoriteCount: post.favoriteCount)
//                                        Spacer()
//                                        VStack{
//                                            HStack{
//                                                Spacer()
//                                                NavigationLink{
//                                                    UpdatePostView(postId: post.id)
//                                                } label: {
//                                                    Image(systemName: "pencil")
//                                                }
//                                                .padding()
//                                                Button(action: {
//                                                    self.idPost = post.id
//                                                    isShowingDialog = true
//                                                }) {
//                                                    Image(systemName: "trash")
//                                                }
//                                                .confirmationDialog("Вы действительно хотите удалить запись?", isPresented: $isShowingDialog, titleVisibility: .visible){
//                                                    Button("Подтвердить", role: .destructive){
//                                                        vm.removePostFetcher(id: idPost)
//                                                        vm.myPosts.removeAll(where: {$0.id == idPost})
//                                                    }
//                                                    Button("Отменить", role: .cancel){
//
//                                                    }
//                                                }
//
//                                            }
//                                            Spacer()
//                                        }
//                                        .padding(20)
//                                        VStack{
//                                            Spacer()
//                                            HStack{
//                                                Image(systemName: "eye")
//                                                    .frame(width: 20)
//                                                Text("\(post.views)")
//                                                Image(systemName: "heart.circle")
//                                                    .frame(width: 20)
//                                                Text("\(post.favoriteCount)")
//                                                Spacer()
//                                            }
//                                            .padding(.leading,15)
//
//                                        }.padding(15)
//
//
//                                    }
//
//                                }
//                                .padding(.vertical, 5)
//
//
//                            }
//                        }
//                        .refreshable {
//                            vm.getMyPostFetcher()
//                        }
                        
                    }else{
                        Text("Публикация пока нет")
                            .font(.title)
                    }
                    
                }
                .padding(.horizontal, 7)
                    
                
            }
            .environmentObject(vm)
            .padding(.bottom, 50)
        }
        .onAppear(perform: {
            vm.getMyPostFetcher()
            vm.getInfoUserFetch()
            self.vm.objectWillChange.send()
        })
    }
    
}

struct PersonalAreaView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalAreaView()
    }
}
