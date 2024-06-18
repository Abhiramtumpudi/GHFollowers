//
//  Date+Ext.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 10/06/24.
//

import Foundation


extension Date {
    
    func convertToMonthyear()-> String {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
