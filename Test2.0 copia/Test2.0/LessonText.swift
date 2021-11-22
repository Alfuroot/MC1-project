//
//  LessonText.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct LessonText: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var item: Item
    @Binding var showlesson: Bool

    var body: some View {
        NavigationView {
            
            VStack {
                
                Form{
                    
                    Text("\(item.lessontxt!)")
                        .frame( height: 695, alignment: .topLeading)
                        .font(.body)
                    
                }.listRowInsets(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                
            } .navigationTitle("\(item.title!)")
            
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            showlesson = false
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    
                }.navigationBarTitleDisplayMode(.inline)
            
            
            
        
        }
        
    }
    
}
