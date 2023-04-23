//
//  PersonalCard.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct PersonalCard: View {
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var date: String
    var body: some View {
        VStack{
            HStack{
                VStack{
                    HStack{
                        Text("\(firstName) \(lastName)")
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.leading, 25)
                            .padding(.top, 25)
                            .padding(.bottom, 15)
                        Spacer()
                    }
                    HStack{
                        Text(email)
                            .font(.system(size: 13, weight: .medium))
                            .padding(.leading, 25)
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        Text("Дата регистрации: \(date)")
                            .font(.system(size: 13, weight: .regular))
                            .padding(.leading, 25)
                        Spacer()
                    }
                    Spacer()
                }
                ProfileImage()
            }
            
            
        }
        .frame(width: 350, height: 150)
        .background(Color("lightGray"))
        .cornerRadius(30)
            
    }
}

struct PersonalCard_Previews: PreviewProvider {
    static var previews: some View {
        PersonalCard(firstName: "Александр", lastName: "Гусев", email: "fgoosev@yandex.ru", date: "21 апреля")
    }
}
