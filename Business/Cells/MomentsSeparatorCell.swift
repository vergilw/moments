//
//  MomentsSeparatorCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/15.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsSeparatorCell: UITableViewCell {

    fileprivate var separatorImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIConstants.Color.separator
        return imgView
    }()
    
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
        contentView.addSubview(separatorImgView)
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        separatorImgView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
