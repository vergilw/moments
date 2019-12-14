//
//  MomentsAPI.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

let MomentsProvider = MoyaProvider<MomentsAPI>(manager: DefaultAlamofireManager.sharedManager)

enum MomentsAPI {
    case moments
}

extension MomentsAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: ServerHost)!
    }
    
    public var path: String {
        switch self {
        case .moments:
            return "/user/jsmith/tweets"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .moments:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .moments:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .none
    }
    
    var headers: [String: String]? {
        return nil
    }
}

