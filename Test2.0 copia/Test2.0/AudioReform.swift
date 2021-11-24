import Foundation
import SwiftUI
import Combine
import AVFoundation
let numberOfSamples: Int = 10

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
    let screenSize = UIScreen.main.bounds
    @State var isPlaying = false


    

    @ObservedObject private var mic = AudioVisualizer(numberOfSamples: numberOfSamples)
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (300 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    var body: some View {
     
        
        NavigationView{
            ZStack(alignment: .center){

  
            VStack {
                
                Text("\(makeTimeString(hours: hours, minutes: minutes, seconds: seconds))")
                    .font(.system(size: 40))
                    .padding(.bottom, -40)
                 
            

                if audioRecorder.recording == false {
                  
                    Button(action: {
                        self.isPlaying.toggle()
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
                        ZStack{
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 5)
                                .frame(width: 120, height: 120)
                        
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                        }.padding(.top, 120)
                    }
                } else {
                    HStack{
                       
                    ForEach(mic.soundSamples, id: \.self) { level in
                                        BarView(value: self.normalizeSoundLevel(level: level))
                    }.frame(height: 100)
                            .padding(.bottom, 100)
                        
                    }
                    Button(action: {
                        timer?.invalidate()
                        timer = nil
                        self.seconds = 0
                        self.minutes = 0
                        self.hours = 0
                        isShown = true
                        self.audioRecorder.stopRecording()
                    }) {
                        ZStack{
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 5)
                                .frame(width: 120, height: 120)
                       
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                            .foregroundColor(.red)
                        }.padding(.top, 120)
                    }
                }
            
            }.navigationBarTitle("Voice recorder")
                    .frame(height: screenSize.height)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                 
                    .background(Color.yellow)
                if isShown{Color.black
                    .opacity(0.1).ignoresSafeArea()}
              
                AZAlert(audioRecorder: AudioRecorder(), title: "Audio reformulation", subtitle: "Insert the title to save your registration", isShown: $isShown, text: $text,item: $item, onDone: {text in
                    setAudio()
                    showmodal = false
                })
            }
        }  .interactiveDismissDisabled(isShown)
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


struct BarView: View {

    var value: CGFloat

    var body: some View {
        ZStack {
   
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.cyan, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))

                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 4) / CGFloat(numberOfSamples), height: value)
        }
    }
}
