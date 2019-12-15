//
//  MomentsImageRowCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsImageRowCell: MomentsBaseRowCell {

    fileprivate var imgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgImgView.image = nil
        
        imgImgView.snp.remakeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.top.equalTo(bodyTextLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 90, height: 160))
            make.bottom.equalTo(-UIConstants.Margin.bottom)
        }
        contentView.layoutIfNeeded()
    }
    
    // MARK: - ============= Initialize View =============
    override func initContentView() {
        super.initContentView()
        
        contentView.addSubview(imgImgView)
    }
    
    // MARK: - ============= Constraints =============
    override func initConstraints() {
        super.initConstraints()
        
        breakBodyTextBottomConstraints()
        
        imgImgView.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.top.equalTo(bodyTextLabel.snp.bottom).offset(12)
            make.size.equalTo(CGSize(width: 90, height: 160))
            make.bottom.equalTo(-UIConstants.Margin.bottom)
        }
    }
    
    // MARK: - ============= Reload =============
    override func setup(entity: MomentEntity) {
        super.setup(entity: entity)
        
        if entity.content == nil || entity.content?.count ?? 0 == 0 {
            
            imgImgView.snp.remakeConstraints { make in
                make.leading.equalTo(nicknameLabel)
                make.top.equalTo(nicknameLabel.snp.bottom).offset(12)
                make.size.equalTo(CGSize(width: 90, height: 160))
                make.bottom.equalTo(-UIConstants.Margin.bottom)
            }
            contentView.layoutIfNeeded()
        }
        
        if let string = entity.images?.first?.url {
            ImageCacheService.sharedInstance.imageForUrl(urlString: string) { [weak self] (image, url) in
                if let image = image {
                    self?.imgImgView.image = image
                }
            }
        }
        
    }

}
