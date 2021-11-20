//
//  AudioRecorder.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import UIKit
import AVFoundation
import SwiftUI
import Combine

class AudioRecorder: NSObject,ObservableObject {
    
    override init() {
        super.init()
        fetchRecordings()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startRecording(title: String) {
            let recordingSession = AVAudioSession.sharedInstance()
        
        do {
                    try recordingSession.setCategory(.playAndRecord, mode: .default)
                    try recordingSession.setActive(true)
                } catch {
                    print("Failed to set up recording session")
                }
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(title).m4a")
        let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 12000,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
        
        do {
                    audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                    audioRecorder.record()

                    recording = true
                } catch {
                    print("Could not start recording")
                }
        
        }
    
    func deleteRecording(url: URL){
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Could not delete file: \(error)")
        }
        
        fetchRecordings()
    }
    
    func saveRecording(title: String, text: String){
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let documentDirectory = URL(fileURLWithPath: path)
            let originPath = documentDirectory.appendingPathComponent("\(title).m4a")
            let destinationPath = documentDirectory.appendingPathComponent("\(title)-\(text).m4a")
            try FileManager.default.moveItem(at: originPath, to: destinationPath)
        } catch {
            print(error)
        }
    }
    
    func stopRecording() {
        
            audioRecorder.stop()
            recording = false
        
        fetchRecordings()
        }
    
    func fetchRecordings() {
            recordings.removeAll()
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            for audio in directoryContents {
                    let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
                    recordings.append(recording)
                }
            recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
                objectWillChange.send(self)
        }
    
    func getCreationDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
}
