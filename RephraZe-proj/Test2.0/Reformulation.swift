//
//  Reformulation.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct Reformulation: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var item: Item
    @Binding var showReformulation: Bool
    @Binding var currtxt: String
    @Binding var index: Int
    @State private var showTitleWindow = false
    @State private var lessonContent: String = ""
    var isError = true
    @State var isEditable = false
    
    var body: some View {
        NavigationView {
            Form{
                
                if isEditable {TextEditor(text: $currtxt).frame( height: 695)}
                else{TextEditor(text: .constant(currtxt)).frame( height: 695).disabled(true)}
            }

            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        if isEditable{
                            setTxtref(currtxtx: currtxt)
                            isEditable.toggle()
                            
                        }
                        else{
                            isEditable.toggle()
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
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }).disabled(showTitleWindow)
                }
                
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle(item.reformtxttitle![index])
            
        }.interactiveDismissDisabled(showTitleWindow)
        
    }
    func setTxtref(currtxtx: String){
        withAnimation {
            item.reformtxt![index] = currtxt
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
