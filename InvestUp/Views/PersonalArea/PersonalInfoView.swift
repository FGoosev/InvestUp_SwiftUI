//
//  PersonalInfoView.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import SwiftUI

struct PersonalInfoView: View {
    @State var firstName: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        Button(action: {
                            
                        }){
                            Image("default")
                                .resizable()
                                .clipShape(Capsule())
                                .frame(width: 150, height: 150)
                        }
                        .padding()
                    }
                    VStack{
                        HStack{
                            TextField("Имя", text: self.$firstName)
                                .modifier(TopFloatingHolder(noText: firstName.isEmpty, placeHolderKey: "Имя"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            TextField("Фамилия", text: self.$firstName)
                                .modifier(TopFloatingHolder(noText: firstName.isEmpty, placeHolderKey: "Фамилия"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            Button(action:{
                                
                            }){
                                Text("Сохранить")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Color1"))
                            .cornerRadius(15)
                        }
                        .padding(.bottom, 15)
                        
                    }
                    .frame(width: 350, height: .infinity)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                    
                    VStack{
                        HStack{
                            SecureField("Текущий пароль", text: self.$firstName)
                                .modifier(TopFloatingHolder(noText: firstName.isEmpty, placeHolderKey: "Текущий пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            SecureField("Новый пароль", text: self.$firstName)
                                .modifier(TopFloatingHolder(noText: firstName.isEmpty, placeHolderKey: "Новый пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            SecureField("Повтор нового пароль", text: self.$firstName)
                                .modifier(TopFloatingHolder(noText: firstName.isEmpty, placeHolderKey: "Повтор нового пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            Button(action:{
                                
                            }){
                                Text("Сохранить")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Color1"))
                            .cornerRadius(15)
                        }
                        .padding(.bottom, 15)
                        
                    }
                    .frame(width: 350, height: .infinity)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                    
                    
                    
                }
                
            }
            .padding(.bottom, 75)
        }
        
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView()
    }
}
