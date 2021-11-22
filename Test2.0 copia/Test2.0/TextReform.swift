//
//  TextReform.swift
//  Test2.0
//
//  Created by Naji Achkar on 18/11/21.
//

import SwiftUI

struct TextReform: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var item: Item
    @Binding var showmodal: Bool
    @State private var showTitleWindow = false
    @State private var lessonContent: String = ""
    @State private var lessonTitle: String = ""
    @Binding var txtarray: [String]
    
    var body: some View {
        NavigationView {
            
            ZStack(alignment: .center) {
                VStack {
                    Form{
                        Section(header: Text("Reformulate your lesson with your own words:")
                                    .font(.caption).listRowInsets(EdgeInsets(top: 10, leading: 25, bottom: 0, trailing: 0))){
                            TextEditor(text: $lessonContent).frame( height: 695)
                        }
                    }
                    
                }
                if showTitleWindow{Color.black
                    .opacity(0.1).ignoresSafeArea()}
                
//                AZAlert(title: "Writing reformulation", subtitle: "Insert the title to save your text", isShown: $showTitleWindow, text: $lessonTitle, onDone: { text in
//                    txtarray.append(lessonContent)
//                    addTxtref()
//                    showTitleWindow.toggle()
//                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                })
                
            }
            .navigationTitle("Writing Reformulation")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showTitleWindow.toggle()
                    }, label: {
                        Text("Done")
                    }).disabled(lessonContent.isEmpty || showTitleWindow)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    }).disabled(showTitleWindow)
                }
                
            }.navigationBarTitleDisplayMode(.inline)
            
            
        }.interactiveDismissDisabled(showTitleWindow)
    }
    func addTxtref(){
        withAnimation {
            item.reformtxt = txtarray
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


//struct TextReform_Previews: PreviewProvider {
//    static var previews: some View {
//        TextReform()
//    }
//}
