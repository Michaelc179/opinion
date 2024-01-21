//
//  AnswerView.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//

import SwiftUI
//import SwiftData

struct AnswerView: View {
    var body: some View {
        ZStack(){
            VStack(alignment: .leading, spacing: 50){
                HStack(alignment: .bottom, spacing: 10) { Text("opinions")
                        .font(Font.custom("DMSerifText-Regular", size: 35))
                        .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                        .onAppear {print("AnswerView appeared")}
                        .padding(.leading, 30)
//                        .padding(.trailing, 10)
                        .padding(.vertical, 10)
                        .frame(width: 393, height: 20, alignment: .topLeading)
                }
                HStack(alignment: .center, spacing: 10) {
                    Text("What's a piece of advice you'd give to your younger self and you found out that you were adopted but didn't have money to give back to the elephants on the moon?")
                      .font(Font.custom("PT Serif", size: 25))
                      .foregroundColor(Color(red: 0.06, green: 0.06, blue: 0.06))
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                    .padding(.leading, 30)
//                    .padding(.trailing, 10)
                    .padding(.vertical, 10)
//                    .frame(width: 393, height: 85, alignment: .center)
                    .background(Color(red: 1, green: 0.97, blue: 0.91))
                VStack() {
                    HStack(alignment: .center, spacing: 7) {
                        ZStack() {
                            Circle()
                                .frame(width: 50, height: 50) // Set the size of the circle
                                .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                            Text("🥶")
                                .font(.system(size: 30)) // Set the font size
                        }.padding(.leading, 30)
                        Text("I HATE BLACK PENCILS")
                            .font(Font.custom("PT Serif", size: 15))
                            .foregroundColor(Color(.white))
                            .padding(.leading, 10)
                    }
                }
            }
        } .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .topLeading)
            .background(Color(red: 0.06, green: 0.06, blue: 0.06))
    }
}

#Preview {
    AnswerView()
//        .modelContainer(for: Item.self, inMemory: true)
}
