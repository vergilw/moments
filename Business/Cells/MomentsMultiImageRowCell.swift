//
//  MomentsMultiImageRowCell.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsMultiImageRowCell: MomentsBaseRowCell {
    
    fileprivate let imgDimension: CGFloat = 80
    fileprivate let imgSpacing: CGFloat = 6
    
    fileprivate var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    fileprivate var imgArray: [UIImageView] = {
        var array = [UIImageView]()
        
        for i in 0..<9 {
            let imgView: UIImageView = {
                let imgView = UIImageView()
                imgView.contentMode = .scaleAspectFill
                imgView.clipsToBounds = true
                imgView.isHidden = true
                return imgView
            }()
            
            array.append(imgView)
        }
        return array
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
        
        imgArray.forEach {
            $0.image = nil
            $0.isHidden = true
        }
        
        containerView.snp.remakeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.top.equalTo(bodyTextLabel.snp.bottom).offset(12)
            make.width.equalTo(3 * (imgDimension+imgSpacing) - imgSpacing)
            make.bottom.equalTo(contentView.snp.bottomMargin)
        }
        contentView.layoutIfNeeded()
    }
    
    // MARK: - ============= Initialize View =============
    override func initContentView() {
        super.initContentView()
        
        contentView.addSubview(containerView)
        
        imgArray.forEach {
            containerView.addSubview($0)
        }
    }
    
    // MARK: - ============= Constraints =============
    override func initConstraints() {
        super.initConstraints()
        
        breakBodyTextBottomConstraints()
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(nicknameLabel)
            make.top.equalTo(bodyTextLabel.snp.bottom).offset(12)
            make.width.equalTo(3 * (imgDimension+imgSpacing) - imgSpacing)
            make.bottom.equalTo(-UIConstants.Margin.bottom)
        }
        
        for i in 0..<9 {
            let imgView = imgArray[i]
            imgView.snp.makeConstraints { make in
                make.leading.equalTo(CGFloat(i%3) * (imgDimension+imgSpacing))
                make.top.equalTo(CGFloat(i/3) * (imgDimension+imgSpacing))
                make.size.equalTo(CGSize(width: imgDimension, height: imgDimension))
            }
        }
    }
    
    // MARK: - ============= Reload =============
    override func setup(entity: MomentEntity) {
        super.setup(entity: entity)
        
        guard let images = entity.images else { return }
        
        var index = 0
        for image in images {
            if let string = image.url, let url = URL(string: string) {
                imgArray[index].setImageWith(url, placeholder: nil)
                imgArray[index].isHidden = false
                index += 1
            }
        }
        
        if entity.content == nil || entity.content?.count ?? 0 == 0 {
            containerView.snp.remakeConstraints { make in
                make.leading.equalTo(nicknameLabel)
                make.top.equalTo(nicknameLabel.snp.bottom).offset(12)
                make.width.equalTo(3 * (imgDimension+imgSpacing) - imgSpacing)
                make.bottom.equalTo(-UIConstants.Margin.bottom)
                make.height.equalTo((imgDimension+imgSpacing)*CGFloat((index-1)/3+1)-imgSpacing)
            }
            
        } else {
            containerView.snp.remakeConstraints { make in
                make.leading.equalTo(nicknameLabel)
                make.top.equalTo(bodyTextLabel.snp.bottom).offset(12)
                make.width.equalTo(3 * (imgDimension+imgSpacing) - imgSpacing)
                make.bottom.equalTo(-UIConstants.Margin.bottom)
                make.height.equalTo((imgDimension+imgSpacing)*CGFloat((index-1)/3+1)-imgSpacing)
            }
        }
        
        contentView.layoutIfNeeded()
        
    }
}
