//
//  HUDService.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HUDService {
    
    static let sharedInstance = HUDService()
    
    fileprivate var HUDContainers: [HUDView] = [HUDView]()
    
    private init() { }
    
    func show(string: String) {
        for view in HUDContainers {
            view.removeFromSuperview()
        }
        HUDContainers.removeAll()
        
        let HUD = HUDView()
        HUD.titleLabel.text = string
        if #available(iOS 13, *) {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(HUD)
        } else {
            UIApplication.shared.keyWindow?.addSubview(HUD)
        }
        HUD.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        HUDContainers.append(HUD)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if let _ = HUD.superview {
                HUD.removeFromSuperview()
            }
            if let index = self.HUDContainers.firstIndex(of: HUD) {
                self.HUDContainers.remove(at: index)
            }
        }
    }
    
    func hideAllHUD() {
        for view in HUDContainers {
            view.removeFromSuperview()
        }
        HUDContainers.removeAll()
    }
    
    
}

fileprivate class HUDView: UIView {
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.body
        label.textColor = UIConstants.Color.primaryGreen
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = UIScreenWidth-100
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        layer.shadowOffset = CGSize(width: 0, height: 8.0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 11
        layer.shadowColor = UIColor.black.cgColor
        
        addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { make in
//            make.leading.greaterThanOrEqualTo(26)
//            make.trailing.lessThanOrEqualTo(-26)
//            make.center.equalToSuperview()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        let size = NSString(string: titleLabel.text!).boundingRect(with: CGSize(width: UIScreenWidth-100, height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : titleLabel.font!], context: nil).size
        layer.cornerRadius = (size.height+28)/2
        return CGSize(width: size.width+52, height: size.height+28)
    }
}
