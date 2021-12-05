//
//  ContentView.swift
//  animationTest
//
//  Created by Marc Orel on 03.12.21.
//

import SwiftUI

struct ContentView: View {
    @State private var num = 0
    @State private var animatedVal = 0
    @State private var isHidden : Bool = false
    @State private var progress : Double = 0
    @State private var progressBarFinished = false
    var body: some View {
        
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("Versand"), footer: Text("\(Int(progress * 100))%, Status: \("Warten auf Versand")").font(.custom("small desc", size: 10)).padding(0).offset(y:-8).foregroundColor(Color.gray)) {
                        NavigationLink(destination: Text("Versandübersicht"), label: {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment:.center, spacing: 0) {
                                    Icon(progressBarFinished: $progressBarFinished).overlay(NotificationCircle(digit: $animatedVal, isHidden: $isHidden)).padding(.vertical, 0).padding(.trailing, 10)
                                    VStack(alignment: .leading, spacing: 0) {
                                        HStack(alignment: .center, spacing: 0) {
                                            Text("Übersicht").font(.subheadline)
                                            Spacer()
                                        }.padding(.top, 0)
                                        HStack(alignment: .top, spacing: 0) {
                                            CustomProgressView(animatedVal: $animatedVal, realProgress: $progress)
                                            /*ProgressView(value: progress).padding(.top, 0).padding(.trailing, 0).padding(.bottom, 0)*/
                                                //.animation(.easeIn)
                                        }
                                    }
                                }.padding(.top, 0).padding(.bottom, 0)
                                
                                
                            }
                        }).padding(.top, 0).padding(.bottom, 0)
                        
                    }.padding(0)
                }.padding(.leading, 0).padding(.trailing, 0)
                    .onChange(of: num) { newValue in
                        print(newValue)
                        isHidden = true
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.animatedVal = newValue
                            self.isHidden = false
                        }
                    }
            }
        }
        //CustomProgressView(animatedVal: $animatedVal, realProgress: $progress)
        Button("PLUS") {
            withAnimation(.easeOut(duration: 0.5)) {
                self.num = num + 1
                self.incrementprogress()
            }

        }
        Button("MINUS") {
            if progress != 0 {
                withAnimation(.easeOut(duration: 1)) {
                    self.num = num - 1
                    self.progress = progress - 0.1
                }
                
            }
            
        }
        
    }
    func incrementprogress() -> Void {
        self.progress = progress + 0.1
        if(progress > 0.99) {
            withAnimation(.easeInOut(duration: 0.5)) {
                progressBarFinished.toggle()
                self.progress = 0.0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
