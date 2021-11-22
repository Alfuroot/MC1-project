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
    let screenSize = UIScreen.main.bounds
    //    @State var finalScale: CGFloat = 1
    //    @State var currentScale: CGFloat = 0
    var body: some View {
        
        List{
            //            HStack{
            //                Image(uiImage: imgs!)
            //            }
            TabView{
                ForEach(imgarray, id: \.self){ i in
                    Image(uiImage: i)
                        .resizable()
                        .scaledToFit()
                    
                    //                        I don't know if it works with a scroll view
                    //                        .scaleEffect(finalScale + currentScale)
                    //                        .gesture(
                    //                            MagnificationGesture().onChanged{newScale in currentScale = newScale}
                    //                                .onEnded{scale in finalScale = scale
                    //                                    currentScale = 0
                    //                                })
                }
            }.tabViewStyle(PageTabViewStyle())
                .frame(height: 650)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        }
        
        .navigationTitle("Associated Images")
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItemGroup(placement: .bottomBar){
                Spacer()
                Button(action: {
                    //               INSERT ACTION
                }, label: {
                    Image(systemName: "trash.fill")
                }
                )
            }
        }
    }
}

