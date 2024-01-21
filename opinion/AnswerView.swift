//
//  AnswerView.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//

import SwiftUI
//import SwiftData

struct AnswerView: View {
    @State private var currentQuestion: String = "Share a personal goal you're currently working towards, and what motivates you" // change to firebase axios
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .bottom, spacing: 10) {
                    Text("opinions")
                        .font(Font.custom("DMSerifText-Regular", size: 35))
                        .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                        .onAppear { print("AnswerView appeared") }
                        .padding(.leading, 30)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                }
                HStack(alignment: .top, spacing: 10) {
                    Text(currentQuestion)
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("PT Serif", size: 25))
                        .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
//                        .foregroundColor(Color(red: 0.06, green: 0.06, blue: 0.06))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(.leading, 30)
                .padding(.vertical, 10)
//                .background(Color(red: 1, green: 0.97, blue: 0.91))
                .background(Color(red: 0.06, green: 0.06, blue: 0.06))


                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ForEach(0..<10) { _ in
                            ResponseComponent()
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.trailing, 30)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(red: 0.06, green: 0.06, blue: 0.06))
    }
}

struct ResponseComponent: View {
    @State private var Emoji: String = "🥳"
    @State private var Response: String = "buhhh"
    @State private var isLiked = false

    var body: some View {
        HStack(alignment: .center, spacing: 7) {
            ZStack() {
                Circle()
                    .frame(width: 50, height: 50) // Set the size of the circle
                    .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                Text(Emoji)
                    .font(.system(size: 30)) // Set the font size
            }.padding(.leading, 30)
            Text(Response)
                .font(Font.custom("PT Serif", size: 18))
                .foregroundColor(Color(.white))
                .padding(.leading, 10)
            Spacer()
            Button(action: {
                // Toggle the value of the `isLiked` variable when the button is tapped
                self.isLiked.toggle()
            }) {
                // Use an image or label to indicate that the button is a "like" button
                Image(systemName: self.isLiked ? "heart.fill" : "heart")
//                Text(isLiked ? "Liked" : "Like")
            }/*.buttonStyle(.bordered)*/
                .tint(.pink)
        }.onTapGesture(count: 2) {
            print("Double tapped!")
            self.isLiked.toggle()
        }.sensoryFeedback(.impact(weight: .heavy, intensity: 10), trigger: self.isLiked)

    }
}

//struct LikeButton: View {
//    // Use a `@State` variable to track whether the button is liked or not
//
//        var body: some View {
//           
//        }
//    }

#Preview {
    AnswerView()
//        .modelContainer(for: Item.self, inMemory: true)
}
