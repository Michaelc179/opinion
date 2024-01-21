//
//  Answer.swift
//  opinion
//
//  Created by Kian Kishimoto on 1/20/24.
//

import Foundation
import SwiftUI
struct Answer: View {
    var screenWidth: CGFloat {
            UIScreen.main.bounds.width
    }
    var body: some View {
        HStack(spacing: 16) {
//            Circle().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Image("Isolation_Mode")
                .resizable()
                .scaledToFit()
            HStack {
                Text("hehehe")
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }.frame(width: screenWidth - 40, height: 57)
            .padding(12)
            .background(Color(red: 255/255, green: 247/255, blue: 232/255))
            .cornerRadius(10)
            
            
    }
}

struct AnswerPreview: PreviewProvider {
    
    static var previews: some View {
        
        Answer()

    }
}
