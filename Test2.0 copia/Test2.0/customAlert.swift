//
//  customAlert.swift
//  Test2.0
//
//  Created by Naji Achkar on 19/11/21.
//

import SwiftUI

struct AZAlert: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    let screenSize = UIScreen.main.bounds
    var title: String = ""
    var subtitle: String = ""
    
    @Binding var isShown: Bool
    @Binding var text: String
    @Binding var item: Item
    @State private var err: Bool = false
    
    var onDone: (String) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    var body: some View {
        VStack {
            
            Text(title)
                .font(.headline)
            
            if (err == false){
                Text(subtitle)
                    .font(.subheadline)
            } else {
                Text("A file with this title already exists.").foregroundColor(Color.red).font(.subheadline)
            }
            
            TextField("Title...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical, 5)
            
            Divider().frame(width: screenSize.width * 0.7)
            
            HStack {
                
                Button("Cancel") {
                    self.isShown = false
                    self.onCancel()
                }.padding().frame(maxWidth: .infinity)
                
                Divider().frame(height: 57)
                
                Button("Done") {
                    if (self.audioRecorder.saveRecording(title: item.title!, text: text)){
                        self.isShown = false
                        self.onDone(self.text)
                    }
                    else {
                        self.err = true
                    }
                    //                    self.isShown = false
                    //                    self.onDone(self.text)
                }.padding().frame(maxWidth: .infinity)
                    .disabled(text.isEmpty)
            }.fixedSize(horizontal: false, vertical: true)
                .frame(height: 40)
        }
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.2)
        .background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height)
        //        .animation(.spring())
        .shadow(color: Color(#colorLiteral(red: 0.8596749902, green: 0.854565084, blue: 0.8636032343, alpha: 1)), radius: 6, x: -9, y: -9)
        
    }
}

//struct AZAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        AZAlert(title: "Add Item", isShown: .constant(true), text: .constant(""))
//    }
//}
