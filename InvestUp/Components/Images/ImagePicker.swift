//
//  ImagePicker.swift
//  InvestUp
//
//  Created by Александр Гусев on 25.04.2023.
//

import SwiftUI
import AVKit

struct ImagePickerTest: View {
    @State private var videoURL: URL?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var show: Bool = false
    //MARK: Lets run the app
    var body: some View {
        VStack{
            if let videoURL = videoURL{
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .aspectRatio(contentMode: .fit)
            }else{
                Button(action:{
                    self.show.toggle()
                }){
                    Text("Pick")
                }
            }
        }
        .sheet(isPresented: self.$show, content: {
            VideoPicker(videoURL: self.$videoURL, show: self.$show, mediaType: ["public.movie"])
        })
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerTest()
    }
}
    
struct ImagePicker: UIViewControllerRepresentable{
    @Binding var image: UIImage?
    
    private let controller = UIImagePickerController()
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        let parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
