//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
