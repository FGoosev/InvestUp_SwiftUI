//
//  CheckMarkPopoverView.swift
//  InvestUp
//
//  Created by Александр Гусев on 14.05.2023.
//

import SwiftUI

struct CheckMarkPopoverView: View {
    @State var list = [TagServer(id:"1",value: "1"), TagServer(id:"2",value: "2"), TagServer(id:"3",value: "3")]
    @State var addLists: [TagServer] = []
    var body: some View {
//        ScrollView(.horizontal){
//            HStack{
//
//
//            }
//        }
//        .padding(.horizontal, 7)
//        .padding(.bottom,5)
//
        List{
            ForEach(list, id: \.id) { item in
                HStack{
                    Button(action: {
                        if addLists.contains(where: {$0.id == item.id}){
                            addLists.removeAll(where: {$0.id == item.id})
                        }else{
                            addLists.append(item)
                        }
                        
                    }){
                        HStack{
                            Image(systemName: addLists.contains(where: {$0.id == item.id}) ? "minus" : "plus")
                            Text(item.value)
                        }
                            .foregroundColor(.white)
                            .font(.system(size: 13))
                            .padding(.horizontal,10)
                            .frame(width: 100,height: 30)
                            .background(Color.green)
                            .clipShape(Capsule())
                    }
                    
                }
                .padding(.horizontal, 5)
                
            }
        }
    }
}

struct CheckMarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkPopoverView()
    }
}
