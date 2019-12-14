//
//  CommentEntity.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import HandyJSON

class CommentEntity: HandyJSON {
    
    var content: String?
    var sender: UserEntity?
    
    required init() { }
    
}
