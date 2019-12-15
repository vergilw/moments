//
//  MomentsCommentRowCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsCommentRowCell: UITableViewCell {

    fileprivate var bgView: UIView = {
        let imgView = UIView()
        imgView.backgroundColor = UIColor("#f3f3f4")
        return imgView
    }()
    
    fileprivate var bodyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.h2
        label.textColor = UIConstants.Color.body
        label.numberOfLines = 0
        return label
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bodyTextLabel.text = nil
    }
    
    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        contentView.addSubviews([bgView, bodyTextLabel])
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        bgView.snp.makeConstraints { make in
            make.leading.equalTo(UIConstants.Margin.leading+42+12)
            make.trailing.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
        bodyTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(bgView).offset(10)
            make.trailing.lessThanOrEqualTo(bgView).offset(-10)
            make.top.equalTo(3)
            make.bottom.equalTo(-3)
        }
    }
    
    // MARK: - ============= Reload =============
    func setup(entity: CommentEntity) {
        if let sender = entity.sender?.nick, let content = entity.content {
            let string = sender + " : " + content
            
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIConstants.Color.selectable], range: NSString(string: string).range(of: sender))
            bodyTextLabel.attributedText = attributedString
        }
        
    }
}
