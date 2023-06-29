//
//  PersonalInfoView.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import SwiftUI
import PhotosUI

struct PersonalInfoView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var viewModel: PersonalInfoViewModel
    @State var shouldShowImagePicker = false
    @State var img: UIImage?
    @State var repeatPassword: String = ""
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    HStack{
                        VStack{
                            Button(action:{
                                shouldShowImagePicker.toggle()
                            }){
                                if let img = img{
                                    Image(uiImage: img)
                                        .resizable()
                                        .frame(width: 120, height: 150)
                                        .clipShape(Circle())
                                }else if viewModel.user.avatar == nil{
                                    Image("default")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                }
                                else{
                                    AsyncImage(url: URL(string: viewModel.user.avatar!)){ image in
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 150)
                                            .clipShape(Circle())
                                    }placeholder: {
                                        Rectangle()
                                            .foregroundColor(.gray.opacity(0.3))
                                            .frame(width: 150, height: 150)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            
                            Button(action: {
                                viewModel.changeAvatarFetcher(paramName: "paramName", fileName: "MyFirstAvatar.png", image: img ?? UIImage())
                            }){
                                Text("Отправить")
                            }
                            
                        }

                    }
                    VStack{
                        HStack{
                            TextField("Имя", text: self.$viewModel.user.firstName)
                                .modifier(TopFloatingHolder(noText: viewModel.user.firstName.isEmpty, placeHolderKey: "Имя"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            TextField("Фамилия", text: self.$viewModel.user.lastName)
                                .modifier(TopFloatingHolder(noText: viewModel.user.lastName.isEmpty, placeHolderKey: "Фамилия"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            Button(action:{
                                viewModel.updateInfoFetch()
                                self.presentation.wrappedValue.dismiss()
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
                            SecureField("Текущий пароль", text: self.$viewModel.passwordRequest.password)
                                .modifier(TopFloatingHolder(noText: viewModel.passwordRequest.password.isEmpty, placeHolderKey: "Текущий пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            SecureField("Новый пароль", text: self.$viewModel.passwordRequest.newPassword)
                                .modifier(TopFloatingHolder(noText: viewModel.passwordRequest.newPassword.isEmpty, placeHolderKey: "Новый пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            SecureField("Повтор нового пароль", text: self.$repeatPassword)
                                .modifier(TopFloatingHolder(noText: repeatPassword.isEmpty, placeHolderKey: "Повтор нового пароль"))
                                .frame(height: 48)
                                .padding()
                                
                        }
                        HStack{
                            Button(action:{
                                if(viewModel.passwordRequest.newPassword == repeatPassword){
                                    viewModel.changePasswordFetcher()
                                    viewModel.passwordRequest.password = ""
                                    viewModel.passwordRequest.newPassword = ""
                                    repeatPassword = ""
                                }else{
                                    print("Пароли не совпадают")
                                }
                                self.presentation.wrappedValue.dismiss()
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
            .padding(.bottom, 50)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Редактирование личного кабинета")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil){
            ImagePicker(image: $img)
                .ignoresSafeArea()
        }
        
    }
}

//struct PersonalInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalInfoView(userModel: <#Binding<UserModel>#>)
//    }
//}
