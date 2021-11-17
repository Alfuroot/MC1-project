//
//  Lesson.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 16/11/21.
//

import SwiftUI

struct Lesson: View {
    
    var item: Item
    
    var body: some View {
        VStack{
            Text("\(item.lessontxt!)")
        }
    }
}

//struct Lesson_Previews: PreviewProvider {
//    static var previews: some View {
//        Lesson()
//    }
//}
