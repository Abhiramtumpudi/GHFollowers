//
//  ErrorMessages.swift
//  GHFollwers
//
//  Created by Abhiram Tumpudi on 20/05/24.
//

import Foundation


enum GFError : String, Error {
    
    case invalidUsername  = "Invalid username created is inValid Request . please check it."
    case unableTocomplete = "Verify throwing error while connecting to network."
    case responseError    = "check the server response from error . please try again."
    case serverDataError  = "unable to convert data from server and decoding error."
    
}
