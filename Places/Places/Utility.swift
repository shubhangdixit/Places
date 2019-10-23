//
//  Utility.swift
//  Places
//
//  Created by Shubhang Dixit on 23/10/19.
//  Copyright © 2019 Shubhang. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    class func controller(forIdentifier name : String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: name)
        return viewController
    }
    
    
    struct Fonts {
        static func avenirNextMedium(withSize size: CGFloat) -> UIFont {
            if let font = UIFont(name: "AvenirNext-Medium", size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func avenirNextRegular(withSize size: CGFloat) -> UIFont {
            if let font = UIFont(name: "AvenirNext-Regular", size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func avenirNextCondensedMedium(withSize size: CGFloat) -> UIFont {
            if let font = UIFont(name: "AvenirNextCondensed-Medium", size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func avenirNextCondensedBold(withSize size: CGFloat) -> UIFont {
            if let font = UIFont(name: "AvenirNextCondensed-Bold", size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
        
        static func avenirNextCondensedRegular(withSize size: CGFloat) -> UIFont {
            if let font = UIFont(name: "AvenirNextCondensed-Regular", size: size) {
                return font
            } else {
                return UIFont.systemFont(ofSize: size)
            }
        }
    }
}
