//
//  MainView.swift
//  InvestUp
//
//  Created by Александр Гусев on 23.04.2023.
//

import SwiftUI

struct MainView: View {
    @State var search: String = ""
    let titles: [String] = ["Какую работу найти?", "Как устроено инвестирование", "Что такое стартап?"]
    var body: some View {
        ScrollView{
            HStack{
                Search(search: $search)
                    .padding()
            }
            HStack{
                Text("Полезные советы")
                    .font(.system(size: 20, weight: .heavy))
                    
                Spacer()
            }
            .padding(.leading, 10)
            ScrollView(.horizontal){
                HStack {
                    ForEach(titles, id: \.self){ item in
                        NewsCard(title: item)
                            
                    }
                }
                .padding(10)
            }
           
            HStack{
                Text("Интересное за последнее время")
                    .font(.system(size: 20, weight: .heavy))
                Spacer()
            }
            .padding(.leading, 10)
            VStack{
                ForEach(0 ..< 5) { item in
                    PostCart(title: "Дизайн в SwiftUI",
                             titleTag: "IT Технологии",
                             description: "Есть много вариантов Lorem Ipsum, но большинство из них имеет не всегда приемлемые модификации.",
                             date: "Опубликовано 21 апреля")
                }
            }
            
            Spacer()
        }
        .padding(.bottom, 75)
        //.shadow(color: Color(.black).opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
