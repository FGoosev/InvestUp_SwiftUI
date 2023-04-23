//
//  TopFloatingHolder.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import Foundation
import SwiftUI

public struct TopFloatingHolder: ViewModifier{
    let noText: Bool
    let placeHolderKey: LocalizedStringKey
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading){
            VStack{
                Spacer()
                
                Rectangle()
                    .frame(height: 0.5)
                    .padding(.bottom, 8)
            }
            Text(placeHolderKey)
                .offset(x: 0, y: noText ? 0 : -20)
                .font(.system(size: noText ? 17 : 14))
                .foregroundColor(.black.opacity(noText ? 0.4 : 0.6))
            
            content
        }
        .animation(.easeOut(duration: 0.4), value: noText)
    }
    
}
