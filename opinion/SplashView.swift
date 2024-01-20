//
//  SplashView.swift
//  RTK_Spike
//
//  Created by Jason Cheladyn on 2022/04/04.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.all).colorScheme(.light)
                VStack {
                    Image("Quotes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.6 * 181, height: 0.6 * 143)
                    
                    Image("opinions")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.6 * 315, height:  80, alignment: .center)
                }
            }
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
