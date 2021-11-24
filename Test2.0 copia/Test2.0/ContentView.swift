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
    
    var body: some View {
        NavigationView{
            List {
                ForEach(items) { item in
                    Section{
                        VStack (alignment: .leading){
                            Text("\(item.title!)")
                                .foregroundColor(item.pin ? Color.white : Color.black)
                                .font(.title3)
                                .bold()
                                .lineLimit(1)
                            
                            Text("\(item.tag!)\n")
                                .font(.subheadline)
                                .foregroundColor(item.pin ? Color.white : Color.black)
                                .lineLimit(1)
                            
                            HStack{
                                
                                if (item.audiocount > 0){
                                    Image(systemName: "mic")
                                        .foregroundColor(item.pin ? Color.white : Color.gray)
                                }
                                if (item.imgicon == true){
                                    Image(systemName: "photo")
                                        .foregroundColor(item.pin ? Color.white : Color.gray)
                                }
                                if (item.txticon == true){
                                    Image(systemName: "highlighter")
                                        .foregroundColor(item.pin ? Color.white : Color.gray)
                                }
                                
                                Spacer()
                                
                                if (item.pin == true){
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(Color.white)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                                }
                                
                                
                                
                                NavigationLink(destination: MyLesson(audioRecorder: AudioRecorder(), item: item)){
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: 0)
                                .opacity(0)
                                
                                
                            }
                            .padding(.top, 5)
                            
                        }
                        
                    }.frame(height: 75)
                        .listRowBackground(item.pin ? Color("AccentColor") : Color.white)
                        .swipeActions(edge: .leading) {
                            Button {
                                pinLesson(item: item)
                            } label: {
                                Label(item.pin ? "Remove" : "Add", systemImage: "pin.fill")
                                
                            }
                            .tint(item.pin ? Color.gray : Color("AccentColor"))
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                delete(item: item)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                                
                            }
                            .tint(Color.red)
                        }
                    
                }
                .foregroundColor(Color.gray)
                .padding(.vertical, 10)
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

            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .sheet(isPresented: $showmodal) {
            AddLesson(showmodal: $showmodal)
        }
    }
    func pinLesson(item: Item){
        withAnimation {
            if (item.pin == true){
                item.pin = false
            } else{item.pin = true }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    func delete(item: Item) {
        withAnimation {
            viewContext.delete(item)
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
