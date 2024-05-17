//
//  TitleAndContentView.swift
//  
//
//  Created by Ho Le Minh Thach on 12/02/2024.
//

import SwiftUI

struct TitleAndContentView: View {

    @Binding var title: String
    @Binding var content: String
    
    var contentHeight: Double
    var contentOpacity: Double = 1
    var contentAnimationTrigger: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text(title)
                .foregroundStyle(Color.accentColor)
                .font(.system(.largeTitle, design: .monospaced))
            
            TextView(text: $content)
                .frame(height: contentHeight)
                .opacity(contentOpacity)
                .animation(.easeInOut(duration: 1), value: contentAnimationTrigger)
        }
    }
}
