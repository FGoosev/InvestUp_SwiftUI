//
//  ProfileImage.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        Image("original")
            .resizable()
            .clipShape(Circle())
            .frame(width: 100)
            .padding()
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
