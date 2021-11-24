//
//  ListAudio.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI
import AVFoundation

struct ListAudio: View {
    
    
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    @Binding var item: Item
    @State var isPlaying = false
    @State var showRecord: Bool = false
    @State var recordurl: URL?
    @State private var time: Float64 = 0
    @State var timer: Timer? = nil


    
    var body: some View {
        
            List{
                ForEach((audioRecorder.recordings), id: \.createdAt) { recording in
                    if (recording.fileURL.lastPathComponent.contains("\(item.title!)-")) {
                        HStack{
                            let audioAsset = AVURLAsset.init(url: recording.fileURL, options: nil)
                            let duration = audioAsset.duration
                            let durationInSeconds = CMTimeGetSeconds(duration)
                            let formatter = DateComponentsFormatter()
                            if audioPlayer.isPlaying == false {
                                Button(action: {
                                    self.audioPlayer.startPlayback(audio: recording.fileURL)
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

                            
                            VStack(alignment: .leading){
//                                let audioAsset = AVURLAsset.init(url: recording.fileURL, options: nil)
//                                let duration = audioAsset.duration
//                                let durationInSeconds = CMTimeGetSeconds(duration)
//                                let formatter = DateComponentsFormatter()
                                Text("\(recording.fileURL.lastPathComponent)")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
//                                    .frame(maxWidth: 150)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                                                
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
                            }
                            Spacer()
                            VStack{
                                Spacer()
                                Text("...")
                            }
                        }
                        .frame(height: 70)
                            .background(Color.white)
                           
                            .onTapGesture{
                                recordurl = recording.fileURL
                                self.showRecord = true
                            }
                    }
                }
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
            .navigationTitle("Voice Reformulation")
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Text("\(item.audiocount) recordings")
                    
                }
                
            
        
        }        .sheet(isPresented: $showRecord){
            Record(audioRecorder: AudioRecorder(), item: $item, showRecord: $showRecord, recordurl: $recordurl).onDisappear(perform: {showRecord = false})
        }
    }
    
}


//struct ListAudio_Previews: PreviewProvider {
//    static var previews: some View {
//        ListAudio()
//    }
//}

