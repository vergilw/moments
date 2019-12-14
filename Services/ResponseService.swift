//
//  ResponseService.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation
import Moya

class ResponseService {
    
    static let sharedInstance = ResponseService()
    
    private init() { }
    
    enum ResponseError: Error {
        case serialization
        case statusCode
        case network
    }
    
    func response(completion: @escaping (_ code: Int, _ resultJSON: ([[String: Any]])?)->()) -> Completion {
        let returnCompletion: Completion = { result in
            switch result {
            case let .success(response):
                
                if response.statusCode >= 200 && response.statusCode < 300 {
                    
                    guard let JSON = ((try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]]) as [[String : Any]]??) else {
                        return completion(response.statusCode, nil)
                    }
                    
                    completion(response.statusCode, JSON)
                    
                } else {
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        if let errorMsg = JSON as? String {
                            #if DEBUG
                            print("\(errorMsg)")
                            #endif
                            HUDService.sharedInstance.show(string: errorMsg)
                            
                        } else if let dictionary = JSON as? [String: Any], let errorMsg = dictionary["message"] as? String {
                            #if DEBUG
                            print("\(errorMsg)")
                            #endif
                            HUDService.sharedInstance.show(string: errorMsg)
                        }
                        
                        completion(-1, nil)
                    } catch {
                        HUDService.sharedInstance.show(string: "服务端错误")
                        completion(-1, nil)
                    }
                }
            case .failure(_):
                HUDService.sharedInstance.show(string: "网络异常")
                completion(-2, nil)
            }
        }
        return returnCompletion
    }
}
