//
//  Icon.swift
//  animationTest
//
//  Created by Marc Orel on 03.12.21.
//

import SwiftUI

struct Icon: View {
    @Binding var progressBarFinished: Bool
    @State private var scaleAnim: Double = 1
    var body: some View {
        ZStack {
            Rectangle().fill(Color.green).frame(width: 30, height: 30).cornerRadius(8)
            Image(systemName: "paperplane")
                .foregroundColor(Color.white)
                .rotationEffect(progressBarFinished ? Angle(degrees: 360): Angle(degrees: 0))
                .scaleEffect(CGFloat(scaleAnim))
        }
        
        .onChange(of: progressBarFinished) { newVal in
            withAnimation {
                self.scaleAnim = 1
            }
        }
        
    }
}

struct Icon_Previews: PreviewProvider {
    @State static var finished = false
    static var previews: some View {
        Icon(progressBarFinished: $finished)
    }
}
