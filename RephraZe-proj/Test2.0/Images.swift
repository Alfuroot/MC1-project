//
//  Images.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI

struct Images: View {
    
    @Binding var imgarray: [UIImage]
    @State var imgs: UIImage?
    @State private var imgarray2: [UIImage] = []
    let screenSize = UIScreen.main.bounds
    var body: some View {
        
        List{
            TabView{
                ForEach(imgarray2, id: \.self){ i in
                    Image(uiImage: i)
                        .resizable()
                    //                        .rotationEffect(.degrees(90))
                        .scaledToFit()
                }
            }.tabViewStyle(PageTabViewStyle())
                .frame(height: 650)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        }
        .onAppear(perform: {
            imgarray2 = imgarray
            orderImgarray(imgs: imgs!, imgarrayx: imgarray2)
        })
        
        .navigationTitle("Associated Images")
        
        .navigationBarTitleDisplayMode(.inline)    }
    
    func orderImgarray(imgs: UIImage, imgarrayx: [UIImage]) {
        
        for img in imgarrayx {
            if (imgs == img){
                self.imgarray2.removeAll{$0 == img}
                self.imgarray2.insert(img, at: 0)
            }
        }
    }
}

