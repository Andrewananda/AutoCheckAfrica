//
//  Extensions.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = .systemGray2
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    func placeholderText(text: String) {
        self.attributedPlaceholder = NSAttributedString(string:text, attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}

extension String{
    
    func strikeThrough() -> NSAttributedString {
            let attributeString =  NSMutableAttributedString(string: self)
            attributeString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                   value: NSUnderlineStyle.single.rawValue,
                       range:NSMakeRange(0,attributeString.length))
            return attributeString
        }
}
