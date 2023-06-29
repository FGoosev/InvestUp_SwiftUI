//
//  MainView.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = MainViewModel()
    @ObservedObject var vm = FavoritesViewModel()
    @ObservedObject var postDetailViewModel = PostDetailViewModel()
    @State var search: String = ""
    let titles: [String] = ["Какую работу найти?", "Как устроено инвестирование", "Что такое стартап?"]
    
    @State var addLists: [String] = []
    
    @State private var tagSelection: String? = nil

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
                        ForEach(viewModel.tags) { item in
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
            
               
                HStack{
                    Text("Интересное за последнее время")
                        .font(.system(size: 20, weight: .heavy))
                    Spacer()
                }
                .padding(.leading, 10)
                
                VStack{
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
                                         tags: item.tags,imageUrl: item.user.avatar ?? "",views: item.views, favoriteCount: item.favoriteCount)
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
                                            vm.addFavoriteFetch(id: item.id)
                                            viewModel.posts.removeAll(where: {$0.id == item.id})
                                        }){
                                            Text("Избранное")
                                                .foregroundColor(.white)
                                                .fontWeight(.regular)
                                                .padding(.vertical, 4)
                                                .padding(.horizontal, 25)
                                                .background(.green)
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
                                                .padding(.vertical, 4.5)
                                                .padding(.horizontal, 25)
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
                }
                
                Spacer()
            }
            .onAppear(perform: viewModel.getPostsFetch)
            .padding(.bottom, 50)
            //.shadow(color: Color(.black).opacity(0.2), radius: 10, x: 0, y: 10)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Главная")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
