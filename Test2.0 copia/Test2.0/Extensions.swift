//
//  Extensions.swift
//  Test2.0
//
//  Created by Giuseppe Carannante on 17/11/21.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
