//
//  AudioView.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import SwiftUI
import AVFoundation

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var item: Item
    
    var body: some View {
        ForEach((audioRecorder.recordings), id: \.createdAt) { recording in
            if (recording.fileURL.lastPathComponent.contains("\(item.title!)")) {
                HStack{
                    RecordingRow(audioURL: recording.fileURL, item: $item, audioRecorder: AudioRecorder())
                }
                .cornerRadius(10)
            }
        }.frame(width: 300, height: 90)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    @State var isPlaying = false
    @Binding var item: Item
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.circle.fill").font(Font.system(size: 55))
                }
            }
            VStack(alignment: .leading){
                let audioAsset = AVURLAsset.init(url: audioURL, options: nil)
                let duration = audioAsset.duration
                let durationInSeconds = CMTimeGetSeconds(duration)
                let formatter = DateComponentsFormatter()
                Text("\(audioURL.lastPathComponent)")
                    .font(.body)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
                
                Text("\(formatter.string(from: durationInSeconds)!)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            VStack{
                //                    if isPinned{ Image(systemName: "pin.fill").font(Font.system(size: 17)
                //                    )
                //                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))}
                Spacer()
                Text("...")
            }.padding(EdgeInsets(top: 5, leading: 27, bottom: 5, trailing: 5))
        }.frame(width: 300, height: 90)
            .background(Color.white)
            .contextMenu {
                Button(action: {
                    // insert pin action
                }) {
                    Text("Pin")
                    Image(systemName: "pin.fill")
                }
                Button(action: {
                    audioRecorder.deleteRecording(url: audioURL)
                }) {
                    Text("Delete")
                    Image(systemName: "trash.fill")
                }
            }
    }
    
}

//struct RecordingsList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingsList(audioRecorder: AudioRecorder())
//    }
//}
