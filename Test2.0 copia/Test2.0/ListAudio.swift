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
    
    
    var body: some View {
        VStack{
            List{
                ForEach((audioRecorder.recordings), id: \.createdAt) { recording in
                    if (recording.fileURL.lastPathComponent.contains("\(item.title!)-")) {
                        HStack{
                            if audioPlayer.isPlaying == false {
                                Button(action: {
                                    self.audioPlayer.startPlayback(audio: recording.fileURL)
                                }) {
                                    Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                                        .padding(.leading, 10)
                                }
                            } else {
                                Button(action: {
                                    self.audioPlayer.stopPlayback()
                                }) {
                                    Image(systemName: "stop.circle.fill").font(Font.system(size: 55))
                                        .padding(.leading, 10)
                                }
                            }
                            VStack(alignment: .leading){
                                let audioAsset = AVURLAsset.init(url: recording.fileURL, options: nil)
                                let duration = audioAsset.duration
                                let durationInSeconds = CMTimeGetSeconds(duration)
                                let formatter = DateComponentsFormatter()
                                Text("\(recording.fileURL.lastPathComponent)")
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                    .frame(height: 10)
                                    .frame(maxWidth: 150)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                
                                Text("\(formatter.string(from: durationInSeconds)!)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            VStack{
                                Spacer()
                                Text("...")
                            }.padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        }.frame(height: 90)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
            .navigationTitle("Voice Reformulation")
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Text("\(item.audiocount) recordings")
                    
                }
                
            }
        
        }
    }
    
}


//struct ListAudio_Previews: PreviewProvider {
//    static var previews: some View {
//        ListAudio()
//    }
//}

