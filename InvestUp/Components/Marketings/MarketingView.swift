//
//  MarketingView.swift
//  InvestUp
//
//  Created by Александр Гусев on 06.05.2023.
//

import SwiftUI

struct MarketingView: View {
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    @State var imageUrl: String
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
                }
                ProfileImage(imageUrl: imageUrl)
            }
            
            
        }
        .frame(width: .infinity, height: 100)
        .background()
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

struct MarketingView_Previews: PreviewProvider {
    static var previews: some View {
        MarketingView(firstName: "Александр", lastName: "Гусев", email: "fgoosev@yandex.ru",imageUrl: "https://assets.website-files.com/5a50853c30cd7400011a7d1b/5a9edb578d9f5b00013b4e67_avatar-1577909_1280.png")
    }
}
