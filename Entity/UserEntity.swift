//
//  UserEntity.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import HandyJSON

class UserEntity: HandyJSON {
    
    var username: String?
    var nick: String?
    var avatar: String?
    
    required init() { }
    
}
