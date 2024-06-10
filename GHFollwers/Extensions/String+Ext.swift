//
//  String+Ext.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 10/06/24.
//

import Foundation


extension String {
    
    func dateConversion()-> Date? {
        let dateformatter           = DateFormatter()
        dateformatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformatter.locale        = Locale(identifier: "en_US_POSIX")
        dateformatter.timeZone      = .current        
        return dateformatter.date(from: self)
    }
    
    func convertTodateDispaly()-> String {
        guard let date = self.dateConversion() else {return "N/A" }
        return date.convertToMonthyear()
    
    }
}
