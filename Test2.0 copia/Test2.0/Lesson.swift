//
//  Lesson.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 16/11/21.
//

import SwiftUI

struct Lesson: View {
    
    var item: Item
    @State var showingActionSheet: Bool = false
    @State var showaudio: Bool = false
    var body: some View {
        NavigationView{
            Text("\(item.lessontxt!)")
            
        }
        .sheet(isPresented: $showaudio) {
            AudioReform(audioRecorder: AudioRecorder())
        }
        .confirmationDialog("",isPresented: $showingActionSheet) {
            Button("Audio reformulation"){
                showaudio = true
            }
            Button("Associate image"){
                
            }
            Button("Writing reformulation"){
                
            }
        }
        .navigationTitle("\(item.title!)")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    self.showingActionSheet = true
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct Lesson_Previews: PreviewProvider {
//    static var previews: some View {
//        Lesson()
//    }
//}
