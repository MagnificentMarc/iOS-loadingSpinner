//
//  CustomProgressView.swift
//  animationTest
//
//  Created by Marc Orel on 04.12.21.
//

import SwiftUI

struct CustomProgressView: View {
    @Binding var animatedVal: Int
    @Binding var realProgress: Double
    @State var changecolor : Bool = false
    @State var currentProgress = 0.00
    @State var add = true
    //Timer
    @State private var timer = Timer.publish(every: 0.30, on: .main, in: .common).autoconnect()
    //Base colors
    var col2 = Color.blue
    var col = Color.blue.opacity(0.300)
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Capsule().fill(
                        Color.black.opacity(0.05)
                    )
                        .frame(width: geometry.size.width, height: 5)
                }
                
                Capsule().fill(
                    LinearGradient(gradient: .init(colors: [col2.opacity(1), col.opacity(1), col2.opacity(1)]), startPoint: UnitPoint(x: CGFloat(currentProgress), y: CGFloat(0.0)), endPoint: UnitPoint(x: CGFloat(currentProgress + 0.5), y: CGFloat(1)))
                )
                    .frame(width: geometry.size.width*realProgress, height: 5)
            }.padding(.top, 3)
            
            
                .onChange(of: animatedVal) { newVal in
                    self.changecolor.toggle()
                }.onDisappear {
                    self.timer.upstream.connect().cancel()
                }.onReceive(timer) { time in
                    //print(time)
                    animateValues()
                }
                .onAppear() {
                    self.timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
                }
        }
        
    }
    func animateValues() {
        if self.currentProgress >= 1.1 {
            self.currentProgress = -0.5
        }
        withAnimation(.easeInOut(duration: 0.33)) {
            
            self.currentProgress += 0.2
            
            /*if self.currentProgress >= 0.98 {
             self.add = false
             } else if self.currentProgress <= 0.08 {
             self.add = true
             }
             if(add) {
             self.currentProgress += 0.1
             } else {
             self.currentProgress -= 0.1
             }*/
            
            
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    @State static var ab : Int = 2
    @State static var rp : Double = 0.2
    static var previews: some View {
        CustomProgressView(animatedVal: $ab, realProgress: $rp)
    }
}
