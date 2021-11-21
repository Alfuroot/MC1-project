//
//  LessonCard.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import SwiftUI

struct LessonCard: View {
    
    @Binding var item: Item
    
    var body: some View {
        VStack (alignment: .leading){
            Text("\(item.title!)")
                .foregroundColor(Color.black)
                .bold();
            
            
            Text("\(item.tag!)\n");
            HStack{
                if (item.audioicon == true){
                    Image(systemName: "mic.fill")
                }
                if (item.imgicon == true){
                    Image(systemName: "photo")
                }
                if (item.txticon == true){
                    Image(systemName: "doc.text.fill")
                }
            }
        }
    }
}

//struct LessonCard_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonCard()
//    }
//}
