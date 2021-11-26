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
                                    if (time >= durationInSeconds){
                                        self.audioPlayer.stopPlayback()
                                        timer?.invalidate()
                                        timer = nil
                                        time = 0
                                    }
                                }
                            }) {
                                Image(systemName: "play.circle.fill").font(Font.system(size: 65))
                                    .padding(.leading, 10)
                            }
                        } else {
                            Button(action: {
                                self.audioPlayer.stopPlayback()
                                timer?.invalidate()
                                timer = nil
                                time = 0
                            }) {
                                Image(systemName: "stop.circle.fill").font(Font.system(size: 65))
                                    .padding(.leading, 10)
                            }
                        }
                        VStack{
                            Slider(value: $time, in: 0...durationInSeconds).disabled(true)
                                .padding(.horizontal)
                                .padding(.bottom, 2)
                                .padding(.top, 25)
                            
                            HStack{
                                Spacer()
                                if durationInSeconds < 10{
                                    Text("00:0\(formatter.string(from: durationInSeconds)!)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                } else if durationInSeconds < 60 {
                                    Text("00:\(formatter.string(from: durationInSeconds)!)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                } else if durationInSeconds < 600 {
                                    Text("0\(formatter.string(from: durationInSeconds)!)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                } else {
                                    Text("\(formatter.string(from: durationInSeconds)!)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }.padding(.trailing, 20)
                            
                        }
                        
                    }.listRowBackground(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                    
                    Section{
                        
                        TextEditor(text: $transcription2)
                            .disabled(true)
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
        .onDisappear(perform: {if (audioPlayer.isPlaying == true) {
            audioPlayer.stopPlayback()
        }})
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
