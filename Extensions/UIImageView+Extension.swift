//
//  UIImageView+Extension.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/15.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

extension UIImageView {
    
    var isHiddenInStackView: Bool {
        get {
            return isHidden
        }
        set {
            if isHidden != newValue {
                isHidden = newValue
            }
        }
    }
}
