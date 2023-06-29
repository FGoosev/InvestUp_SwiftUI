//
//  ProfileImage.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI


struct ProfileImage: View {
    @State var imageUrl: String
    var body: some View {
        if(imageUrl == ""){
            Image("default")
                .resizable()
                .clipShape(Circle())
                .frame(width: 70)
                .padding()
        }else{
            AsyncImage(url: URL(string: imageUrl)){ image in
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
}


struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(imageUrl: "https://assets.website-files.com/5a50853c30cd7400011a7d1b/5a9edb578d9f5b00013b4e67_avatar-1577909_1280.png")
    }
}
