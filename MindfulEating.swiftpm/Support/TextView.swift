//
//  TextView.swift
//
//
//  Created by Ho Le Minh Thach on 11/02/2024.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    func makeUIView(context: Context) -> UITextView {
        let uiTextView = UITextView(frame: .zero)
        uiTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        uiTextView.textAlignment = .justified
        uiTextView.isEditable = false
        uiTextView.translatesAutoresizingMaskIntoConstraints = false
        uiTextView.textContainer.lineBreakMode = .byWordWrapping
        return uiTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
}
