//
//  LessonCard.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import SwiftUI

struct LessonCard: View {
    
    var item: Item
    
    var body: some View {
        VStack (alignment: .leading){
            Text("\(item.title!)")
                .foregroundColor(Color.black)
                .bold();
            
            
            Text("\(item.tag!)\n");
            HStack{
                Image(systemName: "mic.fill")
                Image(systemName: "mic.fill")
            }
        }
    }
}

//struct LessonCard_Previews: PreviewProvider {
//    static var previews: some View {
//        LessonCard()
//    }
//}
