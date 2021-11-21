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
    @State private var binary: Data?
    @State private var image = UIImage()
    @State private var showPicker = false
    @State private var imgarray: [UIImage] = []
    @State var txtarray: [String] = []
    var isNotCorrect = false
    var lessonIsEmpty = false
    @State var deleteFile: Bool = false
    
    var body: some View {
        
        NavigationView{
            ScrollView() {
                
                HStack{
                    Text("\(item.lessontxt!)")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
                .frame(width: 377, height: 130, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                
                if lessonIsEmpty{
                    Text("Now your lesson is ready, start reformulate it. Good study!")
                        .font(.body)
                        .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)}
                
                HStack{
                    Text("Voice Reformulation")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Show all")
                        .font(.body)
                        .foregroundColor(.blue)
                }.padding(EdgeInsets(top: 10, leading: 16, bottom: 0, trailing: 16))
                
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack{
                        Spacer(minLength: 16)
                        
                        ForEach((audioRecorder.recordings), id: \.createdAt) { recording in
                            if (recording.fileURL.lastPathComponent.contains("\(item.title!)")) {
                                HStack{
                                    HStack {
                                        if audioPlayer.isPlaying == false {
                                            Button(action: {
                                                self.audioPlayer.startPlayback(audio: recording.fileURL)
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
                                            let audioAsset = AVURLAsset.init(url: recording.fileURL, options: nil)
                                            let duration = audioAsset.duration
                                            let durationInSeconds = CMTimeGetSeconds(duration)
                                            let formatter = DateComponentsFormatter()
                                            Text("\(recording.fileURL.lastPathComponent)")
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
                                                audioRecorder.deleteRecording(url: recording.fileURL)
                                            }) {
                                                Text("Delete")
                                                Image(systemName: "trash.fill")
                                            }
                                    }
                                
                                }
                                .cornerRadius(10)
                            }
                        }.frame(width: 300, height: 90)
                        
                        Spacer(minLength: 15)
                    }
                }.frame(maxHeight: .infinity)
                
                HStack{
                    Text("Associated Images")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Show all")
                        .font(.body)
                        .foregroundColor(.blue)
                }.padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Spacer(minLength: 16)
                        
                        ForEach(imgarray, id: \.self) {imgs in
                            ZStack{
                                Image(uiImage: imgs)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .contextMenu {
                                        Button(action: {
                                            // insert pin action
                                        }) {
                                            Text("Pin")
                                            Image(systemName: "pin.fill")
                                        }
                                        Button(action: {
                                            imgarray.removeAll {$0 == imgs}
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
                
                HStack{
                    Text("Writing Reformulation")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text("Show all")
                        .font(.body)
                        .foregroundColor(.blue)
                }.padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
                
                ScrollView (.horizontal, showsIndicators: false){
                    HStack{
                        Spacer(minLength: 16)
                        
                        ForEach(txtarray, id: \.self) {txt in
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(txt)")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -4, trailing: 0))
//                                    if isNotCorrect{
//                                        Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
//                                        ).foregroundColor(Color.blue)
//                                    }
                                    
                                    Spacer()
                                }
                            }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                                .background(Color.white)
                                .contextMenu {
                                    Button(action: {
                                        // insert pin action
                                    }) {
                                        Text("Pin")
                                        Image(systemName: "pin.fill")
                                    }
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
            }.frame(maxWidth: .infinity)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
                
        }
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
                AudioReform(audioRecorder: AudioRecorder(),item: $item, showmodal: $showmodal).onDisappear(perform: {showaudio = false})
            }
            else if (showwriting == true){
                TextReform(item: $item, showmodal: $showmodal, txtarray: $txtarray).onDisappear(perform: {showwriting = false})
            }
        }
        .confirmationDialog("",isPresented: $showingActionSheet) {
            Button("Audio reformulation"){
                showaudio = true
                showmodal = true
            }
            Button("Associate image"){
                showPicker = true
            }
            Button("Writing reformulation"){
                showmodal = true
                showwriting = true
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
    
}
