import Foundation
import SwiftUI
import Combine
import AVFoundation

struct AudioReform: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var item: Item
    @Binding var showmodal: Bool
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timer: Timer? = nil
    @State var name: String = ""
    @State var isShown: Bool = false
    @State var text: String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                
            VStack {
                
                Text("\(makeTimeString(hours: hours, minutes: minutes, seconds: seconds))")
                    .font(.system(size: 56.0))
                    .padding()
                if audioRecorder.recording == false {
                    
                    Button(action: {
                        self.audioRecorder.startRecording(title: item.title!)
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
                              if self.seconds == 59 {
                                self.seconds = 0
                                if self.minutes == 59 {
                                  self.minutes = 0
                                  self.hours = self.hours + 1
                                } else {
                                  self.minutes = self.minutes + 1
                                }
                              } else {
                                self.seconds = self.seconds + 1
                              }
                            }
                    }) {
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
                        timer?.invalidate()
                        timer = nil
                        self.seconds = 0
                        self.minutes = 0
                        self.hours = 0
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
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
        {
            var timeString = ""
            timeString += String(format: "%02d", hours)
            timeString += " : "
            timeString += String(format: "%02d", minutes)
            timeString += " : "
            timeString += String(format: "%02d", seconds)
            return timeString
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
