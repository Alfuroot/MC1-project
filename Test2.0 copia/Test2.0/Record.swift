//
//  Record.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI
import Speech

struct Record: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @Binding var item: Item
    @Binding var showRecord: Bool
    @Binding var recordurl: URL!
    @State private var showTitleWindow = false
    @State private var time: Float64 = 0
    @State private var timer: Timer? = nil
    
    var isError = true
    @State var transcription2: String = ""
    @State var isPlaying = false
    @State var speed = 20.0
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form{
                    HStack{
                        let audioAsset = AVURLAsset.init(url: recordurl, options: nil)
                        let duration = audioAsset.duration
                        let durationInSeconds = CMTimeGetSeconds(duration)
                        let formatter = DateComponentsFormatter()
                        
                        if audioPlayer.isPlaying == false {
                            Button(action: {
                                self.audioPlayer.startPlayback(audio: recordurl)
                                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
                                    time = time + 1
                                    print(time)
                                    if (time >= durationInSeconds){
                                        self.audioPlayer.stopPlayback()
                                        timer?.invalidate()
                                        timer = nil
                                        time = 0
                                    }
                                }
                            }) {
                                Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                                    .padding(.leading, 10)
                            }
                        } else {
                            Button(action: {
                                self.audioPlayer.stopPlayback()
                                timer?.invalidate()
                                timer = nil
                                time = 0
                            }) {
                                Image(systemName: "stop.circle.fill").font(Font.system(size: 55))
                                    .padding(.leading, 10)
                            }
                        }
                        Slider(value: $time, in: 0...durationInSeconds).disabled(!audioPlayer.isPlaying)

                    }.listRowBackground(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                    
                    Section(header:
                                HStack(alignment: .center){
                        if isError{
                            Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
                            ).foregroundColor(Color.yellow)
                            
                            
                            Text("You did not use the keywords correctly")}}
                                .font(.caption).listRowInsets(EdgeInsets(top: 10, leading: 25, bottom: 0, trailing: 0))){
                        
                        TextEditor(text: $transcription2)
                            .disabled(true)
                            .frame(height: 570)
                    }
                }.onAppear(perform: {transcribe(audioURL: recordurl)})
                
            }
            .navigationTitle("\(recordurl.lastPathComponent)")
            
            .toolbar{
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        showRecord = false
                    }, label: {
                        Text("Cancel")
                    }).disabled(showTitleWindow)
                }
                
            }.navigationBarTitleDisplayMode(.inline)
            
            
            
        }
        .interactiveDismissDisabled(showTitleWindow)
        
    }
    func transcribe(audioURL: URL){
        
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        let request = SFSpeechURLRecognitionRequest(url: audioURL)
        
        request.shouldReportPartialResults = true
        if (recognizer?.isAvailable)! {
            
            recognizer?.recognitionTask(with: request) { result, error in
                guard error == nil else { print("Error: \(error!)"); return }
                guard let result = result else { print("No result!"); return }
                
                transcription2 = result.bestTranscription.formattedString
            }
        } else {
            print("Device doesn't support speech recognition")
        }
    }
    
}
