//
//  SplashView.swift
//  RTK_Spike
//
//  Created by Jason Cheladyn on 2022/04/04.
//

import SwiftUI
import SwiftfulLoadingIndicators

struct LoadingView: View {
//    @State private var isActive: Bool = true
    @State private var random: Int = 0;
    @State var navigated = false
    
    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.06, blue: 0.06) // Set background color here
            
            VStack {
                Text("Let's see what others think")
                    .font(Font.custom("PT Serif", size: 25))
                    .foregroundColor(Color(red: 1, green: 0.97, blue: 0.91))
                if random == 1 {
                    LoadingIndicator(animation: .doubleHelix, color: Color(red: 1, green: 0.97, blue: 0.91), size: .medium, speed: .slow)
                } else if random == 2 {
                    LoadingIndicator(animation: .pulseOutlineRepeater, color: Color(red: 1, green: 0.97, blue: 0.91), size: .medium, speed: .slow)
                } else if random == 3 {
                    LoadingIndicator(animation: .threeBallsTriangle, color: Color(red: 1, green: 0.97, blue: 0.91), size: .medium, speed: .slow)
                } else if random == 3 {
                    LoadingIndicator(animation: .barStripes, color: Color(red: 1, green: 0.97, blue: 0.91), size: .medium, speed: .slow)
                } else if random == 4 {
                    LoadingIndicator(animation: .fiveLinesPulse, color: Color(red: 1, green: 0.97, blue: 0.91), size: .medium, speed: .slow)
                }
                

            }
        }
        .edgesIgnoringSafeArea(.all) // Ignore safe area to cover the entire screen

        .onAppear {
            randomAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // show up your view controller
                print("HELLO?")
                navigated = true
//                continue
            }
        }
        if navigated {
            AnswerView()
        }
    }
    
    func randomAnimation() {
        random = Int.random(in: 1...4)
    }
}



struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
