//
//  Gallery.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI


struct Gallery: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var item: Item
    
    @State private var binary: Data?
    @State private var image = UIImage()
    @Binding var showPicker: Bool
    @Binding var imgarray: [UIImage]
    
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{ geo in
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
                                       ], spacing: 3) {
                        ForEach(imgarray, id: \.self) { i in
                            Image(uiImage: i)
                            
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.width/3)
                                .aspectRatio(contentMode: .fill)
                            
                            //                                .font(.system(size: 30))
                            //                                .frame(width: geo.size.width/3, height: geo.size.width/3)
                            //                                .background(Color.red)
                        }
                        Image(systemName: "plus")
                            .foregroundColor(Color.white)
                            .font(.system(size: 30))
                            .frame(width:
                                    geo.size.width/3, height: geo.size.width/3)
                            .background(Color("AccentColor"))
                            .onTapGesture {
                                showPicker = true
                            }
                    }
                    
                }
            }                    .background(.clear)
            
        }.toolbar{
            ToolbarItem(placement: .bottomBar){
                Text("\(imgarray.count) photos")
            }
        }
        //        .onAppear(perform: {
        //            if (item.strdimg != nil){
        //                imgarray = imagesFromCoreData(object: item.strdimg)!
        ////                setImg(imgbool: imgarray.isEmpty)
        //            }
        //        })
        .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
        .navigationTitle("Gallery")
        .navigationBarItems(trailing: Button(action: {
            showPicker = true
        }, label: {
            Image(systemName: "plus")
        }
                                            ))
        .sheet(isPresented: $showPicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image).onDisappear(perform: {
                imgarray.append(image)
                binary = coreDataObjectFromImages(images: imgarray)!
                addImage(binimage: binary!)
                imgarray = imagesFromCoreData(object: item.strdimg)!
                //                setImg(imgbool: imgarray.isEmpty)
            })
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
            //            item.imgicon = true
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

//struct Gallery_Previews: PreviewProvider {
//    static var previews: some View {
//        Gallery()
//    }
//}

