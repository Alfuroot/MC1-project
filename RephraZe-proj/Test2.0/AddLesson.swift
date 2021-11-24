//
//  AddLesson.swift
//  ProjectTest
//
//  Created by Giuseppe Carannante on 15/11/21.
//

import SwiftUI
import CoreData

struct AddLesson: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showmodal : Bool
    @State private var lessonText: String = ""
    @State private var lessonTitle: String = ""
    @State private var lessonTag: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Title and Category:")){
                        
                        TextField("Title...", text: $lessonTitle)
                            
                        TextField("Category...", text: $lessonTag)
                        
                    }
                    Section(header: Text("Paste your lesson here:")) {
                        TextEditor(text: $lessonText).frame(height: 250)
                    }
                }
            }
            .navigationTitle("New lesson")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        addLesson()
                        showmodal = false
                    }, label: {
                        Text("Done")
                    }).disabled(lessonText.isEmpty || lessonTitle.isEmpty || lessonTag.isEmpty)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }.navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func addLesson(){
        withAnimation {
            let newLesson = Item(context: viewContext)
            newLesson.tag = lessonTag
            newLesson.title = lessonTitle
            newLesson.lessontxt = lessonText
            newLesson.pin = false
            newLesson.audioicon = false
            newLesson.imgicon = false
            newLesson.txticon = false
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct AddLesson_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLesson()
//    }
//}
