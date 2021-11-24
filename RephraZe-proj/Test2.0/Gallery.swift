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
                        ForEach(0..<imgarray.count, id: \.self) { index in
                            NavigationLink(destination: Images(imgarray: $imgarray, imgs: imgarray[index])) {
                        
                            Image(uiImage: imgarray[index])
                                .resizable()
                                .rotationEffect(.degrees(90))
                                .frame(width: geo.size.width/3, height: geo.size.width/3)
                                .aspectRatio(contentMode: .fill)

                            }
                            //                                .font(.system(size: 30))
                            //                                .frame(width: geo.size.width/3, height: geo.size.width/3)
                            //                                .background(Color.red)
                        }

                    }
                    
                }
            }                    .background(.clear)
            
        }.toolbar{
            ToolbarItem(placement: .bottomBar){
                Text("\(imgarray.count) photos")
            }
        }

        .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
        .navigationTitle("Gallery")
        
                                            

        
    }
    

}

//struct Gallery_Previews: PreviewProvider {
//    static var previews: some View {
//        Gallery()
//    }
//}

