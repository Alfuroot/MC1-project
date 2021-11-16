//
//  LessonCard.swift
//  ProjectTest
//
//  Created by Giuseppe Carannante on 11/11/21.
//

import UIKit

class Lesson: NSObject {
    var pin: Bool
    var title: String
    var tag: String
    var pinned: Bool
    var txtdoc: Bool
    var audiodoc: Bool
    var imgdoc: Bool
    
    init(title: String, tag: String) {
        self.title = title
        self.tag = tag
        self.pinned = false
        self.txtdoc = false
        self.audiodoc = false
        self.imgdoc = false
        self.pin = false
    }
}
