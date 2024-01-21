//
//  QuestionView.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//

import SwiftUI
//import SwiftData

struct QuestionView: View {
    @State private var textInput: String = ""
    @State private var isAnswered: Bool = false
    @State private var currentQuestion: String = "Are mashed potatoes just Irish guacamole?" // change to firebase axios call (I think)

    var body: some View {
        ZStack {
            if !isAnswered {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .bottom, spacing: 10) {
                        Text("opinions")
                            .font(Font.custom("DMSerifText-Regular", size: 35))
                            .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                    }
                    .padding(.leading, 30)
                    
                    Text(currentQuestion)
                        .font(Font.custom("PTSerif-Regular", size: 25))
                        .foregroundColor(Color.white)
                        .padding(.leading, 30)
                    
                    TextField("Enter text", text: $textInput, onCommit: {
                        isAnswered = true
                        print("ANSWERED!!!!")
                    })
                    .padding()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 15)
                    .font(Font.custom("PTSerif-Regular", size: 25))
                    
                }
            } else {
                AnswerView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.06, green: 0.06, blue: 0.06))
        }
            
        }
        
    }
    
    
}


#Preview {
    QuestionView()
}
