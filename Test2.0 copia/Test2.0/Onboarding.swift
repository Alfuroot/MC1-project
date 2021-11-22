//
//  Onboarding.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct Onboarding: View {
    @State var actualview: String = "Planner"
    @State var isShowed: Bool = false
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Text("Welcome in\n").font(.largeTitle)
                        .fontWeight(.bold) + Text("Blablabla")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                }.padding(.bottom, 80.0)
                    .padding(.top, 30.0)
                
                
                HStack{
                    VStack{
                        Image(systemName: "doc.plaintext")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                            .padding(.bottom, 50.0)
                        
                        Image(systemName: "mic")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                            .padding(.bottom, 50.0)
                        
                        Image(systemName: "photo")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                            .padding(.bottom, 6.0)
                        
                        Image(systemName: "highlighter")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 35, weight: .regular))
                        .padding(.top, 45.0)}
                    
                    
                    VStack(alignment: .leading, spacing: 10.0){
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text("Keyword Research")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            
                            Text("Paste your lesson, get the keywords \nand start your study session.")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text("Voice Reformulation")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            
                            Text("Record your repeat, listen to it again \nor read its transcript.")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text("Associated Images")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            
                            Text("Upload photos from your gallery to \ntrain your visual memory.")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                        
                        VStack(alignment: .leading, spacing: 10.0) {
                            Text("Writing Reformulation")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            
                            Text("Make a summary of your lesson, \nto make it truly yours.")
                                .fontWeight(.regular)
                                .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)}
                        .padding(.bottom)
                        
                    }
                    .padding(.leading)
                    
                }
                
                
                
            }
            Button(action: {isShowed.toggle()}) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 90.0)
                    .padding(.vertical, 15.0)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                //                        .sheet(isPresented: $isShowed) {
                //                            if(actualview=="Planner"){
                ////                                CreatePlannerWorkingView(isShowed: $isShowed, actualview: $actualview)
                //                                                        }else{
                //                                                            NotificationView(isShowed: $isShowed, actualview: $actualview )
                //                                                        }
                //
                //
                //                                                    }
            }
            .padding(.top, 40.0)
        }
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}

