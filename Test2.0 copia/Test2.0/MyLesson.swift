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
    @State var item: Item
    @State var showingActionSheet: Bool = false
    @State var showmodal: Bool = false
    @State var showaudio: Bool = false
    @State var showwriting: Bool = false
    @State private var binary: Data?
    @State private var image = UIImage()
    @State private var showPicker = false
    @State private var imgarray: [UIImage] = []
    @State var text = ""
    var nameReformulation = "Name Reformulation"
    var number = "01.40"
    @State var isPlaying = false
    @State var isPinned = true
    var isNotCorrect = false
    var lessonIsEmpty = false
    
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
                        
                        ForEach(0..<10) {_ in
                            HStack{
                                Button(action: {
                                    isPlaying.toggle()
                                }, label: {
                                    if isPlaying {Image(systemName: "pause.circle.fill").font(Font.system(size: 55))
                                    } else {Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                                    }
                                } )
                                
                                VStack(alignment: .leading){
                                    Text("\(nameReformulation)")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
                                    Text("\(number)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                               }
                                
                                VStack{
                                    if isPinned{ Image(systemName: "pin.fill").font(Font.system(size: 17)
                                    )
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))}
                                    Spacer()
                                    Text("...")
                                }.padding(EdgeInsets(top: 5, leading: 27, bottom: 5, trailing: 5))
                                
                            }.background(Color.white)
                            .cornerRadius(10)
                            .contextMenu {
                                    Button(action: {
                                        // insert pin action
                                        isPinned.toggle()
                                    }) {
                                        Text("Pin")
                                        Image(systemName: "pin.fill")
                                    }
                                    Button(action: {
                                        //                                        mediaItems.delete()
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash.fill")
                                    }
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
                                            //                                        mediaItems.delete()
                                        }) {
                                            Text("Delete")
                                            Image(systemName: "trash.fill")
                                        }
                                    }
                                if isPinned{ Image(systemName: "pin.fill").font(Font.system(size: 17)
                                ).frame(width: 130, height: 130, alignment: .topTrailing)}
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
                        
                        ForEach(0..<10) {_ in
                            VStack(alignment: .leading){
                                HStack{
                                    Text("\(nameReformulation)")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -4, trailing: 0))
                                    if isNotCorrect{
                                        Image(systemName: "exclamationmark.triangle").font(Font.system(size: 17, weight: .bold)
                                        ).foregroundColor(Color.blue)
                                    }
                                    
                                    Spacer()
                                    
                                    if isPinned{ Image(systemName: "pin.fill").font(Font.system(size: 17)
                                    )
                                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: -10))
                                    }
                                }
                                Text("\(text)")
                                    .font(.body)
                                    .foregroundColor(.black)
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
                                    //                                        mediaItems.delete()
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
            .navigationTitle("My lesson")
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
                    })
                    }
                )
        }
        .sheet(isPresented: $showmodal) {
            if (showaudio == true){
                AudioReform(audioRecorder: AudioRecorder(),item: $item, showmodal: $showmodal).onDisappear(perform: {showaudio = false})
            }
            else if (showwriting == true){
                TextReform(item: $item, showmodal: $showmodal).onDisappear(perform: {showwriting = false})
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
            if (item.strdimg != nil){
                imgarray = imagesFromCoreData(object: item.strdimg)!
            }
        })
        
    }

    
    func addImage(binimage: Data){
        withAnimation {
            item.strdimg = binimage
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
