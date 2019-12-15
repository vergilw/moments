//
//  UIConstants.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

let UIScreenWidth = UIScreen.main.bounds.size.width
let UIScreenHeight = UIScreen.main.bounds.size.height


public struct UIConstants {
    
    public struct Color {
        public static let primaryGreen: UIColor = UIColor("#00cddd")
        public static let primaryOrange: UIColor = UIColor("#FF6900")
        public static let primaryRed: UIColor = UIColor("#f05053")
        
        public static let head: UIColor = UIColor("#000")
        public static let subhead: UIColor = UIColor("#333")
        
        public static let body: UIColor = UIColor("#353535")
        
        public static let foot1: UIColor = UIColor("#b7b7b7")
        
        public static let disable: UIColor = UIColor("#ccc")
        public static let background: UIColor = UIColor("#fff")
        public static let separator: UIColor = UIColor("#e1e1e0")
        public static let selectable: UIColor = UIColor("#5b6a91")
    }
    
    public struct Font {
        
        public static let h1: UIFont = UIFont(name: "PingFangSC-Medium", size: 16)!
        public static let h2: UIFont = UIFont(name: "PingFangSC-Regular", size: 15)!
        public static let h3: UIFont = UIFont(name: "PingFangSC-Regular", size: 14)!
        public static let h4: UIFont = UIFont(name: "PingFangSC-Regular", size: 13)!
        
        public static let caption1: UIFont = UIFont(name: "PingFangSC-Regular", size: 11)!
        public static let caption2: UIFont = UIFont(name: "PingFangSC-Medium", size: 15)!
        
        public static let body: UIFont = UIFont(name: "PingFangSC-Regular", size: 16)!
        
        public static let foot1: UIFont = UIFont(name: "PingFangSC-Regular", size: 12)!
        public static let foot2: UIFont = UIFont(name: "PingFangSC-Regular", size: 11)!
        public static let foot3: UIFont = UIFont(name: "PingFangSC-Regular", size: 10)!
    }
    
    public struct Size {
        public static let avatar: CGSize = CGSize(width: 30, height: 30)
    }
    
    public struct Margin {
        public static let leading: CGFloat = 12
        public static let trailing: CGFloat = 12
        public static let top: CGFloat = 16
        public static let bottom: CGFloat = 12
    }
    
    public static let cornerRadius: CGFloat = 3
}
