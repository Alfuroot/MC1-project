//
//  ListAudio.swift
//  Test2.0
//
//  Created by Vito Gallo on 21/11/21.
//

import SwiftUI


struct ListAudio: View {
    
    var nameReformulation = "Name Reformulation"
    @State var speed = 20.0
    var number = "01.40"
    
    @State var isPlaying = false
    
    
    var body: some View {
        VStack{
            List{
                ForEach(0..<10){ _ in
                    HStack{
                        
                        Button(action: {
                            isPlaying.toggle()
                        }, label: {
                            if isPlaying {Image(systemName: "pause.circle.fill").font(Font.system(size: 55))
                                    .foregroundColor(Color("AccentColor"))
                            } else {Image(systemName: "play.circle.fill").font(Font.system(size: 55))
                                    .foregroundColor(Color("AccentColor"))
                            }
                        } )
                        
                        VStack(alignment: .leading){
                            Text("\(nameReformulation)")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
                                .frame( height: 10)
                            
                            Slider(value: $speed,
                                   in: 0...100)
                                .padding(.top, 5)
                            
                            Text("\(number)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }                                .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        
                        
                    }
                    
                }
                //                    .onDelete(perform: delete)
            }
            
            
        }.background(Color(red: 242 / 255, green: 242 / 255, blue: 247 / 255))
        
            .navigationTitle("Voice Reformulation")
        
        //                .navigationBarItems(trailing: Button(action: {
        //                    //               INSERT ACTION
        //                }, label: {
        //                    Image(systemName: "plus")
        //                }
        //                                                    ))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    EditButton().font(Font.system(size: 20))
                    
                }
                ToolbarItemGroup(placement: .bottomBar){
                    Spacer()
                    Text("\(nameReformulation.count) recordings")
                    Spacer()
                    
                    Button(action: {
                        //               INSERT ACTION
                    }, label: {
                        Image(systemName: "square.and.pencil")
                    }
                    )
                }
                
            }
        
        
    }
    
}


struct ListAudio_Previews: PreviewProvider {
    static var previews: some View {
        ListAudio()
    }
}

