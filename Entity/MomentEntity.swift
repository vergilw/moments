//
//  MomentEntity.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import HandyJSON

class MomentEntity: HandyJSON {
    
    var sender: UserEntity?
    var content: String?
    var images: [AssetEntity]?
    var comments: [CommentEntity]?
    
    required init() { }
    
}
