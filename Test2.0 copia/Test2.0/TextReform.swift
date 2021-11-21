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
            GeometryReader { geo in
                            ////////////////////////////////////////////////////////////////////////////////////////////
                    ZStack(alignment: .center) {
                        VStack {
                            Text("Try to reformulate your lesson with your own words:")
                                .font(.callout).italic()
                                .fixedSize(horizontal: false, vertical: true)
                            ////////////////////////////////////////////////////////////////////////////////////////////
                            TextEditor(text: $lessonContent)
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9, alignment: .center)
                                .cornerRadius(10)
                        }
                        ////////////////////////////////////////////////////////////////////////////////////////////
//                        AZAlert(title: "Add Item", isShown: $showTitleWindow, text: $lessonTitle, onDone: { text in
//                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//                            presentationMode.wrappedValue.dismiss()
//                            }
//                        })
                    }
                    .navigationTitle("Text Reformulation")
                /////////////////////////////////  NAVIGATION BAR ITEMS ////////////////////////////////////////////////////////////
                .navigationBarItems(leading: Button(action: { presentationMode.wrappedValue.dismiss()}) { Text("Cancel") },
                                    trailing:  Button(action: {
                    txtarray.append(lessonContent)
                    addTxtref()
                    showTitleWindow.toggle()}) {   Text("Save")  })
                ////////////////////////////////////////////////////////////////////////////////////////////
                .padding()
                .background(Color.gray)
            
        }
    }
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
