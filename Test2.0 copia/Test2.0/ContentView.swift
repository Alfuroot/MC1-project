//
//  ContentView.swift
//  ProjectTest
//
//  Created by Giuseppe Carannante on 09/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "title", ascending: false)],
                  animation: .default)
    
    private var items: FetchedResults<Item>;
    @State var showmodal: Bool = false
    
    var body: some View {
        VStack {
            NavigationView{
                List {
                    ForEach(items) { item in
                        Section{
                            ZStack{
                                LessonCard(item: item)
                            NavigationLink(destination: Lesson(item: item)){
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 0)
                            .opacity(0)
                            }
                        }
                        
                    }
                    .onDelete(perform: delete)
                    .foregroundColor(Color.gray)
                    .padding()
                    .cornerRadius(10)
                }
                .navigationTitle("My Lessons")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            print("aaaa")
                            showmodal = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton().font(Font.system(size: 20))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }.sheet(isPresented: $showmodal) {
            AddLesson(showmodal: $showmodal)
        }
    }
    func delete(at offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
