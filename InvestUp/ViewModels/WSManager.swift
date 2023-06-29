//
//  WSManager.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import Foundation
struct SocketModel: Encodable{
    var event: String
    var token: String
}

struct MessageSocketModel: Codable{
    var token: String
    var dialogId: String
    var event: String
    var text: String
}

class WSManager: ObservableObject{
    @Published var messages = [MessageWSModel]()
    
    var tokenTest = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0NjUwZTkzYjUyYjBhZWI2MDdmMjgzYiIsImVtYWlsIjoidHR0QHlhbmRleC5ydSIsImZpcnN0TmFtZSI6ItCi0LXRgdGC0L7QstGL0Lkg0L_QvtC70YzQt9C-0LLQsNGC0LXQu9GMIiwibGFzdE5hbWUiOiLQotC10YHRgtC40YDQvtCyIiwiYXZhdGFyIjpudWxsLCJpc0NvbmZpcm1lZEVtYWlsIjpmYWxzZSwidXBkYXRlZEF0IjoiMjAyMy0wNS0xOFQwNjo0Nzo0My4yMDFaIiwiY3JlYXRlZEF0IjoiMjAyMy0wNS0xN1QxNzoyNzo0Ny4xNjlaIiwic3RhdHVzIjoiQUNUSVZFIiwicm9sZXMiOlt7ImlkIjoiNjM4M2E2MGFkMWMzODkzMzY2NWZkZWQ3IiwidmFsdWUiOiJVU0VSIn1dLCJpYXQiOjE2ODQzOTI0NjMsImV4cCI6MTY4NDQ3ODg2M30.FOvHGuAYzPIU7WkIij8xDZ_IMUgd6TsyoV0Na0vpRxw"
    //let webSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: "ws://45.9.43.5:4000")!)
    private var webSocketTask: URLSessionWebSocketTask?
    init(){
        self.connectToWebSocket()
    }
    func connectToWebSocket(){
        guard let accessToken = LocalStorage.current.token else { return }
        
        guard let url = URL(string: "ws://45.9.43.5:4000") else{
            return
        }
        var request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        
        self.sendConnection()
        self.ping()
        self.receiveMessage()
    }
    func ping(){
        webSocketTask?.sendPing{ error in
            if let error = error{
                print(error)
            }else{
                print("Ping: \(error)")
            }
        }
    }
    func sendConnection(){
        guard let accessToken = LocalStorage.current.token else { return }
        var socketModel = SocketModel(event: "connection", token: tokenTest)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(socketModel)
        let json = String(data: jsonData!, encoding: String.Encoding.utf8)
        webSocketTask?.send(.string(json ?? "")){ error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    private func receiveMessage() {
        webSocketTask?.receive(completionHandler: { [weak self] result in
            switch result{
            case .success(let message):
                switch message{
                case .data(let data):
                    guard let message = try? JSONDecoder().decode(MessageWSModel.self, from: data) else{
                        return
                    }
                    
                case .string(let message):
                    print("Message \(message)")
                @unknown default:
                    break
                }
            case .failure(let error):
                print("Error \(error)")
            }
            self?.receiveMessage()
        })
    }
}
