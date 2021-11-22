//
//  Lesson.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 16/11/21.
//

import SwiftUI

struct Lesson: View {
    
    @State var item: Item
    @State var showingActionSheet: Bool = false
    @State var showmodal: Bool = false
    @State var showaudio: Bool = false
    @State var showwriting: Bool = false
    @State var showimage: Bool = false
    var body: some View {
        NavigationView{
            Text("\(item.lessontxt!)")
            
        }
        .sheet(isPresented: $showmodal) {
            if (showaudio == true){
                AudioReform(audioRecorder: AudioRecorder(),item: $item, showmodal: $showmodal).onDisappear(perform: {showaudio = false})
            }
            //            else if (showwriting == true){
            //                TextReform(item: $item, showmodal: $showmodal, txtarray: $txtarray).onDisappear(perform: {showwriting = false})
            //            }
            else if (showimage == true){
                
            }
        }
        .confirmationDialog("",isPresented: $showingActionSheet) {
            Button("Audio reformulation"){
                showaudio = true
                showmodal = true
            }
            Button("Associate image"){
                showmodal = true
            }
            Button("Writing reformulation"){
                showmodal = true
                showwriting = true
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
