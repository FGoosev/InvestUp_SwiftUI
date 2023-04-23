//
//  ContentView.swift
//  InvestUp
//
//  Created by Александр Гусев on 22.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State var isAuth = AppManager.IsAuth()
    var body: some View {
        Group{
            isAuth ? AnyView(TabBarView()) : AnyView(SignIn())
//            if(isAuth){
//                TabBarView()
//            }
//            else{
//                SignIn()
//            }
        }.onReceive(AppManager.Auth, perform: {isAuth = $0})
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
