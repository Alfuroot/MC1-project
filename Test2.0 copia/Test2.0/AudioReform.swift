import Foundation
import SwiftUI
import Combine
import AVFoundation

struct AudioReform: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var item: Item
    @Binding var showmodal: Bool
    @State var name: String = ""
    
    var body: some View {
        NavigationView{
            VStack {
                
                RecordingsList(audioRecorder: audioRecorder, item: $item, name: $name)
                
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording(title: item.title!,name: name)}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {self.audioRecorder.stopRecording()}) {
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
        }
    }
}

//struct audioReform_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioReform(audioRecorder: AudioRecorder())
//    }
//}
