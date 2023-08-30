//
//  SplashScreen.swift
//  To-Do-List
//
//  Created by Teboho Mohale on 2023/03/02.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            TaskListView()
        }else{
            HStack{
                HStack{
                    Image("scr")
                    //.resizable()
                        //.frame(width: 500, height: 500)
                        .scaledToFit()
                      //  .foregroundColor(.blue)
                        .padding(.top, -100.0)
                        .opacity(10.0)
                        .padding(.leading, -50)
                        .padding(.bottom, -380)
                        .overlay(
                        Image("splash")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .padding(.top, 750)
                        )
                    
                }
                
                
                
                
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.4)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                    
                }
                
            }
            
            
            
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
    
    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
