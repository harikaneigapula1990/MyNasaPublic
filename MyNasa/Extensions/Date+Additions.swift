//
//  Date+Additions.swift
//  MyNasa
//
//  Created by Dushyanth Potnuru on 29/07/22.
//

import Foundation
extension Date {
    
    func tomorrow() -> Date {
        return self.addingTimeInterval(1*24*60*60)
    }
    
    func yesterday() -> Date {
        return self.addingTimeInterval(-1*24*60*60)
    }
    
    func formattedString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
