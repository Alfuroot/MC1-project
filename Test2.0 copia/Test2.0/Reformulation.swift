//
//  Reformulation.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct Reformulation: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var item: Item
    //    @Binding var showmodal: Bool
    @Binding var showReformulation: Bool
    @Binding var currtxt: String
    @State private var showTitleWindow = false
    @State private var lessonContent: String = ""
    var isError = true
    @State var isEditable = true
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    
                    Section(header:
                                
                                
                                HStack(alignment: .center){
                        if isError{
                            Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
                            ).foregroundColor(Color.yellow)
                            
                            Text("You did not use the keywords correctly")}}
                                .font(.caption).listRowInsets(EdgeInsets(top: 10, leading: 25, bottom: 0, trailing: 0))){
                        
                        if isEditable {TextEditor(text: $currtxt).frame( height: 695)}
                        //                        else {Text ("\(item.reformtxt!)").frame( height: 695)}
                    }
                }
                
            }
            //                .navigationTitle("\(???)")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        if isEditable{
                            isEditable.toggle()
                            //                            lessonContent = self.item.reformtxt!
                        }
                        else{
                            //                            INSERT A SAVE FUNC
                        }
                    }, label: {
                        if isEditable{
                            Text("Save")} else{
                                Text("Edit")
                            }
                    })
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        //                        showReformulation = false
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }).disabled(showTitleWindow)
                }
                
            }.navigationBarTitleDisplayMode(.inline)
            
            
            
        }.interactiveDismissDisabled(showTitleWindow)
        
    }
    
}
