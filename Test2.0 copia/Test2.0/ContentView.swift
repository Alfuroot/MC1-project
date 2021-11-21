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
                  sortDescriptors: [NSSortDescriptor(key: "pin", ascending: false)],
                  animation: .default)
    
    private var items: FetchedResults<Item>;
    @State var showmodal: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            NavigationView{
                List {
                    ForEach(items) { item in
                        Section{
                            HStack{
                                VStack (alignment: .leading){
                                    Text("\(item.title!)")
                                        .foregroundColor(Color.black)
                                        .bold();
                                    
                                    
                                    Text("\(item.tag!)\n");
                                    HStack{
                                        if (item.audioicon == true){
                                            Image(systemName: "mic.fill")
                                        }
                                        if (item.imgicon == true){
                                            Image(systemName: "photo")
                                        }
                                        if (item.txticon == true){
                                            Image(systemName: "doc.text.fill")
                                        }
                                    }
                                }
                            
                                NavigationLink(destination: MyLesson(audioRecorder: AudioRecorder(), item: item)){
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: 0)
                                .opacity(0)
                                
                                
                                if (item.pin == true){
                                    Spacer()
                                    VStack{
                                        Image(systemName: "pin.fill").padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                                    }
                                }
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                pinLesson(item: item)
                            } label: {
                                Label("Add", systemImage: "pin.fill")
                            }
                            .tint(.blue)
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
        }
        .sheet(isPresented: $showmodal) {
            AddLesson(showmodal: $showmodal)
        }
    }
    func pinLesson(item: Item){
        withAnimation {
            item.pin = true
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
