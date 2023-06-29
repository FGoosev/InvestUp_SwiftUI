//
//  VideoPicker.swift
//  InvestUp
//
//  Created by Александр Гусев on 13.05.2023.
//

import Foundation
import SwiftUI
//MARK: We are done with the VideoPicker implementation
struct VideoPicker: UIViewControllerRepresentable{
    let sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var videoURL: URL?
    @Binding var show: Bool
    let mediaType: [String]
    
    func makeCoordinator() -> Coordinator {
        return VideoPicker.Coordinator(video: self)
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.mediaTypes = mediaType
        return picker
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<VideoPicker>) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        var video : VideoPicker
        init(video: VideoPicker) {
            self.video = video
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let videoURL = info[.mediaURL] as? URL{
                self.video.videoURL = videoURL
            }
            self.video.show.toggle()
        }
    }
}
