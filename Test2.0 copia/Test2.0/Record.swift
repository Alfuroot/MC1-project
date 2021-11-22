//
//  Record.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct Record: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var item: Item
    //    @Binding var showmodal: Bool
    @Binding var showRecord: Bool
    
    @State private var showTitleWindow = false
    
    var isError = true
    @State var isPlaying = false
    @State var speed = 20.0
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form{
                    
                    HStack{
                        Button(action: {
                            isPlaying.toggle()
                        }, label: {
                            if isPlaying {Image(systemName: "pause.circle.fill").font(Font.system(size: 55))
                            } else {Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                                
                            }
                        } )
                        
                        Slider(value: $speed,
                               in: 0...100)
                            .padding()
                        
                        
                    }.listRowBackground(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                    
                    Section(header:
                                HStack(alignment: .center){
                        if isError{
                            Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
                            ).foregroundColor(Color.yellow)
                            
                            
                            Text("You did not use the keywords correctly")}}
                                .font(.caption).listRowInsets(EdgeInsets(top: 10, leading: 25, bottom: 0, trailing: 0))){
                        
                        TextEditor(text: .constant("???")).frame( height: 570)
                    }
                }
                
            }
            .navigationTitle("???")
            
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        showRecord = false
                    }, label: {
                        Text("Cancel")
                    }).disabled(showTitleWindow)
                }
                
            }.navigationBarTitleDisplayMode(.inline)
            
            
            
        }.interactiveDismissDisabled(showTitleWindow)
        
    }
    
}
