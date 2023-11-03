//
//  UILabelExtensions.swift
//  MyOwnWorkout
//
//  Created by Олег Попов on 14.10.2023.
//

import UIKit

extension UILabel {
    
    convenience init(_ text: String,
                     _ font: UIFont! = nil,
                     _ textColor: UIColor) {
        self.init()
        self.text = text
        
        if let font = font {
            self.font = font
        }
        
        self.textColor = textColor
    }
}
