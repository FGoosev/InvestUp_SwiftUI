//
//  TabBarView.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct TabBarView: View {
    @State var selectTab = "Главная"
    @ObservedObject var vm = PersonalInfoViewModel()
    let tabs = ["Главная","Избранное","Чаты","Профиль"]
    init(){
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectTab){
                MainView()
                    .tag("Главная")
                
                FavoritesView()
                    .tag("Избранное")
                
                Chats()
                    .tag("Чаты")
                PersonalAreaView()
                    .tag("Профиль")
                    
                
            }
            HStack{
                ForEach(tabs, id: \.self){ tab in
                    Spacer()
                    TabBarItem(tab: tab, imageUrl: vm.user.avatar ?? "", selected: $selectTab)
                    Spacer()
                }
                
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color("lightGray").opacity(0.5))
            
        }
    }
}

struct TabBarItem: View{
    @State var tab: String
    @State var imageUrl: String = ""
    @Binding var selected: String
    var body: some View{
        
        ZStack{
            Button(action:{
                withAnimation(.spring()){
                    selected = tab
                }
                
            }){
                HStack{
                    Image(tab)
                        .resizable()
                        .frame(width: 20, height: 20)
                    if(selected == tab){
                    
                        Text(tab)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                    
                }
            }
        }
        .opacity(selected == tab ? 1 : 0.7)
        .padding(.vertical, 10)
        .padding(.horizontal, 17)
        .background(selected == tab ? .white : Color("lightGray"))
        .clipShape(Capsule())
        
//        if tab == "Профиль"{
//            Button(action: {
//                selected = tab
//            }){
//                ZStack{
//                    Image(tab)
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                }
//            }
//        }else{
//            ZStack{
//                Button(action:{
//                    withAnimation(.spring()){
//                        selected = tab
//                    }
//
//                }){
//                    HStack{
//                        Image(tab)
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                        if(selected == tab){
//
//                            Text(tab)
//                                .font(.system(size: 14))
//                                .foregroundColor(.black)
//                        }
//
//                    }
//                }
//            }
//            .opacity(selected == tab ? 1 : 0.7)
//            .padding(.vertical, 10)
//            .padding(.horizontal, 17)
//            .background(selected == tab ? .white : Color("lightGray"))
//            .clipShape(Capsule())
//        }
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
