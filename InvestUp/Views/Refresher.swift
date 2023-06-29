//
//  Refresher.swift
//  InvestUp
//
//  Created by Александр Гусев on 07.06.2023.
//

import SwiftUI

struct Refresher: View {
    @Environment(\.refresh) private var refresh
        @State private var isLoading = false // 1
    var body: some View {
        VStack {
                    Text("Refresher")
            if isLoading { // 2
                ProgressView()
            } else {
                Button("Refresh") {
                    isLoading = true // 3
                    async {
                        await refresh
                        isLoading = false // 4
                    }
                }
            }
                }
    }
}

struct Refresher_Previews: PreviewProvider {
    static var previews: some View {
        Refresher()
    }
}
