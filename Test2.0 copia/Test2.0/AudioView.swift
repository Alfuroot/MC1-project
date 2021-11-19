//
//  AudioView.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import SwiftUI

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @Binding var item: Item
    @Binding var name: String
    
    var body: some View {
        TextField("Title...", text: $name)
        List {
            ForEach((audioRecorder.recordings), id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL, item: $item)
            }
        }
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    @Binding var item: Item
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        if (audioURL.lastPathComponent.contains("\(item.title!)")){
            HStack {
                Text("\(audioURL.lastPathComponent)")
                Spacer()
                if audioPlayer.isPlaying == false {
                    Button(action: {
                        self.audioPlayer.startPlayback(audio: self.audioURL)
                    }) {
                        Image(systemName: "play.circle")
                            .imageScale(.large)
                    }
                } else {
                    Button(action: {
                        self.audioPlayer.stopPlayback()
                    }) {
                        Image(systemName: "stop.fill")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}

//struct RecordingsList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingsList(audioRecorder: AudioRecorder())
//    }
//}
