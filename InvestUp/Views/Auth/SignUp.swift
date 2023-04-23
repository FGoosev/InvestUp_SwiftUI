//
//  SignUp.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct SignUp: View {
        @ObservedObject var viewModel = RegistrationViewModel()
        var body: some View{
            NavigationView{
                ZStack(alignment: .bottom){
                    VStack{
                        VStack{
                            Text("Регистрация")
                                .foregroundColor(.black)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                TextField("Имя", text: self.$viewModel.model.firstName)
                                
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                TextField("Фамилия", text: self.$viewModel.model.lastName)
                                    .foregroundColor(.black)
                                
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                TextField("Email", text: self.$viewModel.model.email)
                                
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                SecureField("Пароль", text: self.$viewModel.model.password)
                                
                            }
                            Divider().background(Color.white.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        
                        
                    }
                    .padding()
                    .padding(.bottom, 35)
                    .background(.white)
                    .shadow(color: Color.black.opacity(0.3),radius: 5,x: 0,y: -5)
                    .cornerRadius(35 )
                    .padding(.horizontal,20)
                    
                    
                    Button(action:{
                        viewModel.register()
                    }){
                        Text("Регистрация")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color("Color1"))
                            .clipShape(Capsule())
                        
                            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    .offset(y: 25)
                }
            }
            
        }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
