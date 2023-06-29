//
//  CreatePostView.swift
//  InvestUp
//
//  Created by Александр Гусев on 26.04.2023.
//

import SwiftUI
import AVKit

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = CreatePostViewModel()
    @EnvironmentObject var personalAreaVM: PersonalInfoViewModel
    @State var tags: [TagModel] = [TagModel(value: "First"),TagModel(value: "Second"),TagModel(value: "Third"),TagModel(value: "Four")]
    @State var addedTags: [String] = []
    @State var selection: String?
    @State var data: Data?
    @State private var isVideoProcessing: Bool = false
    
    @State private var videoURL: URL?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var show: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    TextField("Название", text: $viewModel.requestModel.title)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 30)
                

                HStack{
                    List(viewModel.tags) { tag in
                        HStack{
                            Image(systemName: viewModel.requestModel.tags.contains(where: {$0 == tag.id}) ? "checkmark.square" : "square")
                                .onTapGesture {
                                    if(viewModel.requestModel.tags.contains(where: {$0 == tag.id})){
                                        viewModel.requestModel.tags.removeAll(where: {$0 == tag.id})
                                    }else{
                                        viewModel.requestModel.tags.append(tag.id)
                                    }

                                }
                            Text(tag.value)
                        }
                    }
                    .listStyle(.inset)
                }
                .frame(height: CGFloat(tags.count) * 40)

                HStack{
                    VStack{
                        Text("Краткое описание")
                        TextEditor(text: $viewModel.requestModel.shortDescription)
                            .border(Color.black)
                            .frame(height: 120)

                    }


                }
                .padding(.horizontal, 15)

                HStack{
                    VStack{
                        Text("Полное описание")
                        TextEditor(text: $viewModel.requestModel.description)
                            .border(Color.black)
                            .frame(height: 120)

                    }


                }
                .padding(.horizontal, 15)

                HStack{
                    VStack{
                        HStack{
                            Spacer()
                            Button(action:{
                                self.show.toggle()
                            }){
                                Text("Выбрать видео")
                            }
                            Spacer()
                            if let url = viewModel.videoUrl{
                                Button("Удалить видео"){
                                    viewModel.videoUrl = URL(string: "")
                                }
                                .padding(5)
                                Spacer()
                            }
                        }

                        ZStack{

                            if let url = viewModel.videoUrl {
                                VideoPlayer(player: .init(url: url))
                            }
                            if isVideoProcessing{
                                Rectangle()
                                    .fill()
                                    .overlay{
                                        ProgressView()
                                    }
                            }
                        }
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))

                    }
                    .sheet(isPresented: self.$show, content: {
                        VideoPicker(videoURL: self.$viewModel.videoUrl, show: self.$show, mediaType: ["public.movie"])
                    })
                    .padding()
                }
                if viewModel.videoUrl != URL(string: ""){
                    Button(action: {
                        viewModel.createPostFetch()
                        
                        self.presentation.wrappedValue.dismiss()
                        
                        
                    }){
                        Text("Создать пост")
                    }
                }
            }
            .onAppear(perform: viewModel.getTagsFetch)
            .padding(.bottom, 75)


        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}

