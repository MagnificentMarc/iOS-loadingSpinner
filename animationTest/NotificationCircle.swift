//
//  NotificationCircle.swift
//  animationTest
//
//  Created by Marc Orel on 03.12.21.
//

import SwiftUI

struct NotificationCircle: View {
    @Binding var digit : Int
    @Binding var isHidden: Bool
    
    var xPos = 30
    var yPos = 2
    
    var body: some View {
        ZStack {
            if digit > 0 {
                Capsule().fill(Color.red).frame(width: 8 * CGFloat(numOfDigits()), height: 12, alignment: .topTrailing).position(CGPoint(x: xPos, y: 0))
                Text("\(digit)")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 10).bold()).position(CGPoint(x: xPos, y: 0)).opacity(isHidden ? 0 : 1).offset(x: isHidden ? 2 : 0)
            }

        }
    }
    func numOfDigits() -> Float {
        let numOfDigits = Float(String(digit).count)
        return numOfDigits == 1 ? 1.5 : numOfDigits
    }
}

struct NotificationCircle_Previews: PreviewProvider {
    @State static var num = 2
    @State static var isHidden = false
    static var previews: some View {
        NotificationCircle(digit: $num, isHidden: $isHidden)
    }
}

