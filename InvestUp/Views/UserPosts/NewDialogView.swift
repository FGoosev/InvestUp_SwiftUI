//
//  NewDialogView.swift
//  InvestUp
//
//  Created by Александр Гусев on 28.05.2023.
//

import SwiftUI

struct NewDialogView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = ChatViewModel()
    @State private var message = ""
    @State var userId = ""
    @State var userImage = ""
    @State var firstName = ""
    @State var lastName = ""
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    if(userImage == ""){
                        Image("default")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 70)
                            .padding()
                    }else{
                        AsyncImage(url: URL(string: userImage ?? "")){ image in
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
                    Text("\(firstName) \(lastName)")
                        .font(.system(size: 25, weight: .semibold))
                }
                .padding(.bottom, 50)
                HStack{
                    TextField("Сообщение", text: $message)
                    Button(action:{
                        viewModel.createDialogFetcher(userId: userId, text: message)
                        self.presentation.wrappedValue.dismiss()
                    }){
                        Image(systemName: "greaterthan.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            
                    }
                }
                Divider()
                Spacer()
            }
            .padding(.horizontal,15)
            .padding(.bottom,150)
        }
    }
}

struct NewDialogView_Previews: PreviewProvider {
    static var previews: some View {
        NewDialogView()
    }
}
