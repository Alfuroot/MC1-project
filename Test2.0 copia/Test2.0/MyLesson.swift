//
//  MyLesson.swift
//  Test2.0
//
//  Created by Vito Gallo on 19/11/21.
//


import SwiftUI
import AVKit
import PhotosUI
import CoreData
import Speech

struct MyLesson: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var isPlaying = false
    @State var item: Item
    @State var showingActionSheet: Bool = false
    @State var showmodal: Bool = false
    @State var showaudio: Bool = false
    @State var showwriting: Bool = false
    @State var showlesson: Bool = false
    @State var showReformulation: Bool = false
    @State var showRecord: Bool = false
    @State private var binary: Data?
    @State private var image = UIImage()
    @State var currtxt: String = ""
    @State var showPicker = false
    @State  var imgarray: [UIImage] = []
    @State var txtarray: [String] = []
    @State private var transcription: String = ""
    var isNotCorrect = false
    var lessonIsEmpty = false
    @State var deleteFile: Bool = false
    
    var body: some View {
        
        ScrollView() {
            HStack{
                Text("\(item.lessontxt!)")
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            }
            .onTapGesture{
                //                showmodal = true
                showlesson = true
            }
            .frame(width: 377, height: 130, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            
            if (imgarray.isEmpty && txtarray.isEmpty && item.audiocount == 0) {
                Text("Now your lesson is ready, start reformulate it. Good study!")
                    .font(.body)
                    .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)}
            else{
                
                if (item.audiocount > 0) {
                HStack{
                    Text("Voice Reformulation")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    NavigationLink(destination: ListAudio()) {
                        
                        Text("Show all")
                            .font(.body)
                            .foregroundColor(Color("AccentColor"))
                    }
                }.padding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
                
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack{
                        Spacer(minLength: 16)
                        
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
                                        //                                                .onTapGesture(perform: {transcribe(audioURL: recording.fileURL)})
                                    }.padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                }.frame(height: 90)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .onTapGesture{
                                        //                                        self.showmodal = true
                                        self.showRecord = true
                                    }
                                    .contextMenu {
                                        Button(action: {
                                            audioRecorder.deleteRecording(url: recording.fileURL)
                                            setAudio()
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash.fill")
                                        }
                                    }
                            }
                        }
                        
                        Spacer(minLength: 15)
                    }
                }.frame(maxHeight: .infinity)
                }
                if (imgarray.count > 0) {
                    HStack{
                        Text("Associated Images")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        NavigationLink(destination: Gallery(item: $item, showPicker: $showPicker, imgarray: $imgarray)) {
                            if imgarray.count > 1{
                                Text("Show all")
                                    .font(.body)
                                .foregroundColor(Color("AccentColor"))}
                        }
                    }.padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            Spacer(minLength: 16)
                            
                            ForEach(0..<imgarray.count, id: \.self) {index in
                                
                                NavigationLink(destination: Images(imgarray: $imgarray, imgs: imgarray[index])) {
                                    
                                    Image(uiImage: imgarray[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .contextMenu {
                                            Button(action: {
                                                imgarray.removeAll {$0 == imgarray[index]}
                                                binary = coreDataObjectFromImages(images: imgarray)!
                                                addImage(binimage: binary!)
                                                imgarray = imagesFromCoreData(object: item.strdimg)!
                                                setImg(imgbool: imgarray.isEmpty)
                                            }) {
                                                Text("Delete")
                                                Image(systemName: "trash.fill")
                                            }
                                        }
                                }
                                
                            }.frame(width: 150, height: 150)
                                .clipped()
                                .cornerRadius(10)
                            
                            Spacer(minLength: 16)
                            
                        }}
                }
                if (txtarray.count > 0) {
                    
                    HStack{
                        Text("Writing Reformulation")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        NavigationLink(destination: ListReformulation(item: $item, txtarray: $txtarray)) {
                            
                            if txtarray.count > 1{
                                Text("Show all")
                                    .font(.body)
                                .foregroundColor(Color("AccentColor"))}
                        }
                    }.padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
                    
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack{
                            Spacer(minLength: 16)
                            
                            ForEach(txtarray, id: \.self) {txt in
                                VStack(alignment: .leading){
                                    HStack{
                                        Text("TITLE!!!")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: -4, trailing: 0))
                                        if isNotCorrect{
                                            Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
                                            ).foregroundColor(Color.blue)
                                        }
                                    }
                                    Text("\(txt)")
                                        .font(.body)
                                        .foregroundColor(.black)
                                    
                                }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                                    .background(Color.white)
                                    .onTapGesture{
                                        currtxt = txt
                                        self.showReformulation = true
                                    }
                                    .contextMenu {
                                        Button(action: {
                                            txtarray.removeAll {$0 == txt}
                                            addTxtref(txtref: txtarray)
                                            setTxt(txtbool: txtarray.isEmpty)
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash.fill")
                                        }
                                    }
                            }.background(Color.white)
                                .frame(width: 310, height: 107)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            Spacer(minLength: 16)
                        }
                    }.frame(maxHeight: .infinity)
                }
            }
            //                Text("\(transcription)")
            
        }
        .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
        .navigationTitle("\(item.title!)")
        .navigationBarItems(trailing: Button(action: {
            self.showingActionSheet = true
        }, label: {
            Image(systemName: "square.and.pencil")
        }).sheet(isPresented: $showPicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image).onDisappear(perform: {
                imgarray.append(image)
                binary = coreDataObjectFromImages(images: imgarray)!
                addImage(binimage: binary!)
                imgarray = imagesFromCoreData(object: item.strdimg)!
                setImg(imgbool: imgarray.isEmpty)
            })
        })
        .sheet(isPresented: $showmodal) {
            if (showaudio == true){
                AudioReform(audioRecorder: AudioRecorder(),item: $item, showmodal: $showmodal).onDisappear(perform: {showaudio.toggle()})
            }
            else if (showwriting == true){
                TextReform(item: $item, showmodal: $showmodal, txtarray: $txtarray).onDisappear(perform: {showwriting.toggle()})
            }
            
        }
        .sheet(isPresented: $showRecord){
            Record(item: $item, showRecord: $showRecord).onDisappear(perform: {showRecord = false})
        }
        .sheet(isPresented: $showlesson){
            LessonText(item: $item, showlesson: $showlesson).onDisappear(perform: {showlesson = false})
        }
        .sheet(isPresented: $showReformulation){
            Reformulation(item: $item, showReformulation: $showReformulation, currtxt: $currtxt).onDisappear(perform: {showReformulation = false})
        }
        .confirmationDialog("",isPresented: $showingActionSheet) {
            Button("Audio reformulation"){
                showaudio.toggle()
                showmodal.toggle()
            }
            Button("Associate image"){
                showPicker = true
            }
            Button("Writing reformulation"){
                showmodal.toggle()
                showwriting.toggle()
            }
        }
        
        .onAppear(perform: {
            if (item.reformtxt != nil){
                txtarray = item.reformtxt!
                setTxt(txtbool: txtarray.isEmpty)
            }
            if (item.strdimg != nil){
                imgarray = imagesFromCoreData(object: item.strdimg)!
                setImg(imgbool: imgarray.isEmpty)
            }
        })
        
    }
    
    func transcribe(audioURL: URL){
        
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        let request = SFSpeechURLRecognitionRequest(url: audioURL)
        
        
        request.shouldReportPartialResults = true
        
        if (recognizer?.isAvailable)! {
            
            recognizer?.recognitionTask(with: request) { result, error in
                guard error == nil else { print("Error: \(error!)"); return }
                guard let result = result else { print("No result!"); return }
                
                transcription = result.bestTranscription.formattedString
            }
        } else {
            print("Device doesn't support speech recognition")
        }
    }
    
    func setTxt(txtbool: Bool){
        withAnimation {
            item.txticon = !txtbool
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addTxtref(txtref: [String]){
        withAnimation {
            item.reformtxt = txtref
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func setImg(imgbool: Bool){
        withAnimation {
            item.imgicon = !imgbool
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addImage(binimage: Data){
        withAnimation {
            item.strdimg = binimage
            item.imgicon = true
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func coreDataObjectFromImages(images: [UIImage]) -> Data? {
        let dataArray = NSMutableArray()
        for img in images {
            
            if let data = img.pngData() {
                dataArray.add(data)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }
    
    func imagesFromCoreData(object: Data?) -> [UIImage]? {
        var retVal = [UIImage]()
        guard let object = object else { return nil }
        
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data, let image = UIImage(data: data) {
                    retVal.append(image)
                }
            }
        }
        return retVal
    }
    
    func setAudio(){
        withAnimation {
            item.audiocount = item.audiocount - 1
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error (nsError), (nsError.userInfo)")
            }
        }
    }
}
