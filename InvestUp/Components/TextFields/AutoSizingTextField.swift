//
//  AutoSizingTextField.swift
//  InvestUp
//
//  Created by Александр Гусев on 30.04.2023.
//

import SwiftUI

struct AutoSizingTextField: View {
    @State var titleTF = ""
    @State var text = ""
    @State var containerHeight: CGFloat = 0
    var body: some View {
        VStack{
            AutoSizingTF(hint: titleTF, text: $text, containerHeight: $containerHeight, onEnd: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
                .padding(.horizontal)
                .frame(height: containerHeight)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.04).ignoresSafeArea())
    }
}

struct AutoSizingTextField_Previews: PreviewProvider {
    static var previews: some View {
        AutoSizingTextField()
    }
}

struct AutoSizingTF: UIViewRepresentable{
        
    var hint: String
    @Binding var text: String
    @Binding var containerHeight: CGFloat
    var onEnd: ()-> ()
    
    func makeCoordinator() -> Coordinator {
        return AutoSizingTF.Coordinator(parent: self)
    }
    
    
    func makeUIView(context: Context) -> UITextView{
        let textView = UITextView()
        textView.text = hint
        textView.textColor = .gray
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 20)
        
        textView.delegate = context.coordinator
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.closeKeyBoard))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [spacer,doneButton]
        toolBar.sizeToFit()
        
        textView.inputAccessoryView = toolBar
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        DispatchQueue.main.async {
            if containerHeight == 0 {
                containerHeight = uiView.contentSize.height
            }
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate{
        var parent: AutoSizingTF
        
        init(parent: AutoSizingTF){
            self.parent = parent
        }
        @objc func closeKeyBoard(){
            parent.onEnd()
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.hint{
                textView.text = ""
                textView.textColor = UIColor(Color.primary)
            }
        }
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.containerHeight = textView.contentSize.height
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == ""{
                textView.text = parent.hint
                textView.textColor = .gray
            }
        }
    }
    
}
