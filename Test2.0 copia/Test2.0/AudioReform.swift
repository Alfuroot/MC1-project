import Foundation
import SwiftUI
import Combine
import AVFoundation

struct AudioReform: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var item: Item
    @Binding var showmodal: Bool
    @State var name: String = ""
    @State var isShown: Bool = false
    @State var text: String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                
            VStack {
                
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording(title: item.title!)}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {
                        isShown = true
                        self.audioRecorder.stopRecording()
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
            }.navigationBarTitle("Voice recorder")
                if isShown{Color.black
                    .opacity(0.1).ignoresSafeArea()}
                AZAlert(audioRecorder: AudioRecorder(), title: "Audio reformulation", subtitle: "Insert the title to save your registration", isShown: $isShown, text: $text,item: $item, onDone: {text in
                    setAudio()
                    showmodal = false
                    
                })
            }
        }
    }
    func setAudio(){
        withAnimation {
            item.audioicon = true
            item.audiocount = item.audiocount + 1
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
//                AZAlert(title: "Audio reformulation", subtitle: "Insert the title to save your registration", isShown: $isShown, text: $text, onDone: {text in
//                    setAudio()
//                    self.audioRecorder.saveRecording(title: item.title!, text: text)
//                    showmodal = false
//                })


//struct audioReform_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioReform(audioRecorder: AudioRecorder())
//    }
//}
