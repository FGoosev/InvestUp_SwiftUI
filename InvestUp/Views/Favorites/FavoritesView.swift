//
//  FavoritesView.swift
//  InvestUp
//
//  Created by Александр Гусев on 06.05.2023.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @ObservedObject var postDetailViewModel = PostDetailViewModel()
    @ObservedObject var mainViewModel = MainViewModel()
    @State var search: String = ""
    let titles: [String] = ["Какую работу найти?", "Как устроено инвестирование", "Что такое стартап?"]
    @State private var tagSelection: String? = nil
    @State var addLists: [String] = []
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .padding(.leading, 5)
                        TextField("Найти", text: $search)
                    }
                    .frame(height: 35)
                    .background(Color.gray.opacity(0.2))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 0.5))
                    .padding()
                }
                ScrollView(.horizontal){
                    HStack{
                        ForEach(mainViewModel.tags) { item in
                            HStack{
                                Button(action: {
                                    if addLists.contains(where: {$0 == item.id}){
                                        addLists.removeAll(where: {$0 == item.id})
                                    }else{
                                        addLists.append(item.id)
                                    }
                                    
                                }){
                                    HStack{
                                        Image(systemName: addLists.contains(where: {$0 == item.id}) ? "minus" : "plus")
                                        Text(item.value)
                                    }
                                        .foregroundColor(.white)
                                        .font(.system(size: 13))
                                        .padding(.horizontal,10)
                                        .frame(width: 100,height: 30)
                                        .background(Color.green)
                                        .clipShape(Capsule())
                                }
                                
                            }
                            .padding(.horizontal, 5)
                            
                        }
                    }
                }
                .padding(.horizontal)
                HStack{
                    Button(action: {
                        viewModel.searchPosts(searchQuery: search,tags: addLists)
                        UIApplication.shared.endEditing()
                    }){
                        Text("Фильтровать")
                            .font(.system(size: 13))
                            .padding(.horizontal,10)
                        
                    }
                    .frame(width: 150,height: 30)
                    
                    .background()
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding()
                    Spacer()
                    Button(action: {
                        viewModel.searchPosts(searchQuery: "",tags: [])
                        UIApplication.shared.endEditing()
                        search = ""
                        addLists = []
                    }){
                        Text("Сбросить")
                            .font(.system(size: 13))
                            .padding(.horizontal,10)
                        
                    }
                    .frame(width: 150,height: 30)
                    
                    .background()
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding()
                }
                VStack{
                    if(viewModel.posts.count > 0){
                        ForEach(viewModel.posts, id: \.id) { item in
                            
                            NavigationLink {
                                PostDetailView(Id: item.id)
                            } label: {
                                ZStack{
                                    PostCart(firstName: item.user.firstName,
                                             lastName: item.user.lastName,
                                        title: item.title,
                                             description: item.shortDescription,
                                             date: item.updatedAt,
                                             tags: item.tags,imageUrl: item.user.avatar ?? "")
                                    Spacer()
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Image(systemName: "eye")
                                                .frame(width: 20)
                                            Text("\(item.views)")
                                            Image(systemName: "heart.circle")
                                                .frame(width: 20)
                                            Text("\(item.favoriteCount)")
                                        }
                                        Spacer()
                                        HStack{
                                            Button(action: {
                                                viewModel.removeFavoriteFetch(id: item.id)
                                                viewModel.posts.removeAll(where: {$0.id == item.id})
                                            }){
                                                Text("Убрать")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.regular)
                                                    .padding(.vertical, 7)
                                                    .padding(.horizontal, 30)
                                                    .background(.orange)
                                                    .clipShape(Capsule())
                                            }
                                            .padding(.leading)
                                            Spacer()
                                            NavigationLink{
                                                UserPostsView(userId: item.user.id)
                                            } label: {
                                                Text("Профиль")
                                                    .foregroundColor(.white)
                                                    .fontWeight(.regular)
                                                    .padding(.vertical, 7)
                                                    .padding(.horizontal, 30)
                                                    .background(.green)
                                                    .clipShape(Capsule())
                                            }
                                            .padding(.trailing)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(10)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }else{
                        Text("В избранном нету записей")
                            .font(.title)
                    }
                    
                }
            }
            .onAppear(perform: viewModel.getFavoritesFetch)
            .padding(.bottom, 50)
        }
        
    }
        
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
