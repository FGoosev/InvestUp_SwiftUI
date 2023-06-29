//
//  UpdatePostView.swift
//  InvestUp
//
//  Created by Александр Гусев on 16.05.2023.
//

import SwiftUI

struct UpdatePostView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = CreatePostViewModel()
    @ObservedObject var postDetailVM = PostDetailViewModel()
    @ObservedObject var updatePostVM = UpdatePostViewModel()
    @State var postId: String = ""
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
                    TextField("Название", text: $postDetailVM.post.title)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 30)
                

                HStack{
                    List(viewModel.tags) { tag in
                        HStack{
                            Image(systemName: postDetailVM.post.tags.contains(where: {$0 == tag}) ? "checkmark.square" : "square")
                                .onTapGesture {
                                    if(postDetailVM.post.tags.contains(where: {$0 == tag})){
                                        postDetailVM.post.tags.removeAll(where: {$0 == tag})
                                    }else{
                                        postDetailVM.post.tags.append(tag)
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
                        TextEditor(text: $postDetailVM.post.shortDescription)
                            .border(Color.black)
                            .frame(height: 120)

                    }


                }
                .padding(.horizontal, 15)

                HStack{
                    VStack{
                        Text("Полное описание")
                        TextEditor(text: $postDetailVM.post.description)
                            .border(Color.black)
                            .frame(height: 120)

                    }


                }
                .padding(.horizontal, 15)

                
                Button(action: {
                    updatePostVM.updatePostFetcher(id: postId, requestModel: UpdatePostRequest(title: postDetailVM.post.title, description: postDetailVM.post.description, shortDescription: postDetailVM.post.shortDescription, tags: postDetailVM.post.tags))
                    self.presentation.wrappedValue.dismiss()
                }){
                    Text("Обновить пост")
                }
            }
            .onAppear(perform: {
                viewModel.getTagsFetch()
                postDetailVM.getPostByIdFetcher(postId: postId)
            })
            .padding(.bottom, 75)


        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UpdatePostView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePostView()
    }
}
