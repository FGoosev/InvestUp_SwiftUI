//
//  ChatViewModel.swift
//  InvestUp
//
//  Created by Александр Гусев on 17.05.2023.
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject{
    
    @Published var chats: [ChatModel] = []
    @Published var chatById: ChatDetailModel = ChatDetailModel(id: "", users: [], messages: [])
    @Published var dialog: DialogModel = DialogModel(id: "", users: [], messages: [])
    private var bag = Set<AnyCancellable>()
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    func getChatsFetcher(){
        let url = "http://45.9.43.5:5000/dialogs"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: [ChatModel].self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] chats in
                    self?.chats = chats
                }
                .store(in: &bag)
        }
    }
    
    func createDialogFetcher(userId: String, text: String){
        let url = "http://45.9.43.5:5000/dialogs/create"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            let body: [String: AnyHashable] = [
                "text": text,
                "userId": userId
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: DialogModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] dialog in
                    self?.dialog = dialog
                }
                .store(in: &bag)
        }
    }
    
    func getChatDetailFetcher(id: String){
        let url = "http://45.9.43.5:5000/dialogs/\(id)"
        guard let accessToken = LocalStorage.current.token else { return }
        if let url = URL(string: url){
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: ChatDetailModel.self, decoder: JSONDecoder())
                .sink{ res in
                    
                } receiveValue: { [weak self] chatById in
                    self?.chatById = chatById
                }
                .store(in: &bag)
        }
    }
    
    init(){
        self.connectToWebSocket()
        self.receiveMessage()
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
        self.receiveMessage()
    }
    
    func sendConnection(){
        guard let accessToken = LocalStorage.current.token else { return }
        var socketModel = SocketModel(event: "connection", token: accessToken)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(socketModel)
        let json = String(data: jsonData!, encoding: String.Encoding.utf8)
        webSocketTask?.send(.string(json ?? "")){ error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func sendMessage(text: String, dialogId: String, user: UserCommentModel){
        guard let accessToken = LocalStorage.current.token else { return }
        var socketModel = MessageSocketModel(token: accessToken, dialogId: dialogId, event: "message",text: text)
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(socketModel)
        let json = String(data: jsonData!, encoding: String.Encoding.utf8)
        webSocketTask?.send(.string(json ?? "")){ error in
            if let error = error {
                print(error.localizedDescription)
            }else{
                var messageModel = MessageModel(id: "", text: text, dialogId: dialogId, updatedAt: "\(Date.now)", createdAt: "\(Date.now)", read: true, user: user)
            
                self.chatById.messages.append(messageModel)
            }
        }
    }
    private func receiveMessage() {
        webSocketTask?.receive(completionHandler: { [weak self] result in
            switch result{
            case .success(let message):
                switch message{
                case .data(let data):
                    print("\(data)")
                    
                case .string(let message):
                    print("qwer" + message)
                    let data = message.data(using: .utf8)
                    guard let message = try? JSONDecoder().decode(MessageWSModel.self, from: data!) else{
                        return
                    }
                    if message.dialogId == self?.chatById.id && message.event == "message"{
                        var messageModel = MessageModel(id: message.id, text: message.text, dialogId: message.dialogId, updatedAt: message.updatedAt, createdAt: message.createdAt, read: message.read, user: message.user)
                    
                        self?.chatById.messages.append(messageModel)
                    }
                    //self?.getMessagePars(message: message)
                    
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

//let data = message.data(using: .utf8)
//guard let message = try? JSONDecoder().decode(MessageWSModel.self, from: data!) else{
//    return
//}
//if message.dialogId == self?.chatById.id{
//    var messageModel = MessageModel(id: message.id, text: message.text, dialogId: message.dialogId, updatedAt: message.updatedAt, createdAt: message.createdAt, read: message.read, user: message.user)
//
//    self?.chatById.messages.append(messageModel)
//
//    var chat = self?.chats.first(where: {$0.id == messageModel.dialogId})
//    if chat != nil{
//        chat?.lastMessage = messageModel
//        self?.chats.append(chat!)
//    }
//
//}
