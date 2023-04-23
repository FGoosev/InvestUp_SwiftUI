//
//  SignIn.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var viewModel = AuthViewModel()
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                ZStack(alignment: .bottom){
                    VStack{
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("Color1"))
                                TextField("Email", text: self.$viewModel.loginModel.email)
                                    .foregroundColor(.black)
                            
                            }
                            Divider().background(Color.black.opacity(0.5))
                        }
                        .padding(.horizontal)
                        .padding(.top, 40)
                        
                        VStack{
                            HStack(spacing: 15){
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(Color("Color1"))
                                SecureField("Пароль", text: self.$viewModel.loginModel.password)
                                    .foregroundColor(.black)
                            
                            }
                            Divider().background(Color.black.opacity(1))
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)
                        
                        HStack{
                            Spacer(minLength: 0)
                            Button(action: {
                            
                            }){
                                Text("Забыли пароль?")
                                    .foregroundColor(Color.black.opacity(0.6))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 30)

                
                    }
                    .padding()
                   
                    .padding(.bottom, 65)
                    //.background(Color("Color2"))
                    .shadow(color: Color.black.opacity(0.3),radius: 5,x: 0,y: -5)
                    .cornerRadius(35 )
                    .padding(.horizontal,20)
                    
                    
                    Button(action:{
                        viewModel.login()
                    }){
                        Text("Авторизация")
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
                Spacer()
                VStack{
                    NavigationLink{
                        SignUp()
                    } label: {
                        Text("Регистрация")
                            .fontWeight(.bold)
                    }
                    .navigationTitle("Авторизация")
                        
                }
                Spacer()
            }
        }
        
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
