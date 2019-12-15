//
//  MomentsBaseRowCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsBaseRowCell: UITableViewCell {

    var avatarImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.h1
        label.textColor = UIConstants.Color.selectable
        return label
    }()
    
    var bodyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.Font.body
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
        
        avatarImgView.image = nil
        nicknameLabel.text = nil
        bodyTextLabel.text = nil
        bodyTextLabel.isHidden = false
    }
    
    // MARK: - ============= Initialize View =============
    func initContentView() {
        contentView.addSubviews([avatarImgView, nicknameLabel, bodyTextLabel])
    }
    
    // MARK: - ============= Constraints =============
    func initConstraints() {
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: UIConstants.Margin.leading, bottom: 0, right: UIConstants.Margin.trailing)
        
        avatarImgView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.top.equalTo(16)
            make.size.equalTo(CGSize(width: 42, height: 42))
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImgView.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailingMargin)
            make.top.equalTo(avatarImgView.snp.top)
            make.height.equalTo(18)
        }
        
        bodyTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailingMargin)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.bottom.equalTo(-UIConstants.Margin.bottom)
        }
    }
    
    func breakBodyTextBottomConstraints() {
        bodyTextLabel.snp.remakeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailingMargin)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
        }
        contentView.layoutIfNeeded()
    }
    
    // MARK: - ============= Reload =============
    func setup(entity: MomentEntity) {
        if let string = entity.sender?.avatar, let url = URL(string: string) {
            avatarImgView.setImageWith(url, placeholder: nil)
        }
        
        nicknameLabel.text  = entity.sender?.nick
        
        if let string = entity.content {
            bodyTextLabel.text = string
        } else {
            bodyTextLabel.isHidden = true
        }
        
    }
    
}
