//
//  MomentsCommentRowCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsCommentRowCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        initContentView()
        initConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        
    }
    
    // MARK: - ============= Reload =============
    func setup(img: UIImage, title: String) {
//        iconImgView.image = img
//
//        titleLabel.text = title
    }
    
    // MARK: - ============= Public =============
    class func fixedHeight() -> CGFloat {
        return 48
    }
}
