//
//  Fonts.swift
//  AutoCheckAfrica
//
//  Created by Andrew Ananda on 24/07/2022.
//

import Foundation
import UIKit

import UIKit

func thinFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now Thin", size: size) ?? UIFont.systemFont(ofSize: size, weight: .thin)
    return font
}

func lightFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
    return font
}

func regularFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    return font
}

func mediumFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    return font
}

func boldFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    return font
}

func blackFont(size: CGFloat) -> UIFont {
    let font = UIFont(name: "Now Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
    return font
}
