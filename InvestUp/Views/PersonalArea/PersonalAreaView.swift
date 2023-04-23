//
//  PersonalAreaView.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct PersonalAreaView: View {
    @ObservedObject var viewModel = PersonalAreaViewModel()
    @ObservedObject var vm = PersonalInfoViewModel()
    let titles: [String] = ["Какую работу найти?", "Как устроено инвестирование", "Что такое стартап?"]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    NavigationLink{
                        PersonalInfoView()
                    } label: {
                        PersonalCard(firstName: vm.user.firstName, lastName: vm.user.lastName, email: vm.user.email, date: "21 апреля")
                    }
                    .navigationTitle("Личный кабинет")
                    
                }
                
                ScrollView(.horizontal){
                    HStack {
                        ForEach(titles, id: \.self){ item in
                            NewsCard(title: item)
                                
                        }
                    }
                    .padding(10)
                }
                
                Spacer()
                HStack{
                    Text("Личные публикации")
                        .font(.system(size: 25, weight: .bold))
                        .padding()
                    Spacer()
                }

                ForEach(0 ..< 5) { item in
                    PersonalPost()
                        .padding(.bottom, 15)
                }
                CreatePostButton(title: "Создать новый пост")
                    .padding(.bottom, 30)
                
                HStack{
                    
                    Button(action: {
                        viewModel.logoutUser()
                    }){
                        Text("Выйти")
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal)
                    
                
            }
            .padding(.bottom, 90)
        }
        
    }
}

struct PersonalAreaView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalAreaView()
    }
}
