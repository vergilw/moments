//
//  MomentsViewModel.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation

class MomentsViewModel {
    
    var remoteMomentEntities: [MomentEntity]?
    var localMomentEntities: [MomentEntity]?
    var dataPerPage: Int = 5
    var dataHasMore: Bool?
    
    fileprivate func fetchRemoteData(completion: @escaping ()->Void) {
        MomentsProvider.request(.moments, completion: ResponseService.sharedInstance.response(completion: { (code,JSON) in
            
            self.remoteMomentEntities = []
            if let moments = JSON {
                for moment in moments {
                    if let entity = MomentEntity.deserialize(from: moment),
                        (entity.content?.count ?? 0 > 0 || entity.images?.count ?? 0 > 0) {
                        self.remoteMomentEntities?.append(entity)
                    }
                }
            }
            
            completion()
        }))
    }
    
    fileprivate func loadDataFromLocal(completion: @escaping ()->Void) {
        guard let entities = self.remoteMomentEntities, entities.count > self.localMomentEntities?.count ?? 0 else { return }
        
        let startIndex = self.localMomentEntities?.count ?? 0
        self.localMomentEntities?.append(contentsOf: Array(entities[startIndex..<startIndex+self.dataPerPage]))
        
        if entities.count > self.localMomentEntities?.count ?? 0 {
            self.dataHasMore = true
        } else {
            self.dataHasMore = false
        }
        
        print(self.localMomentEntities?.count ?? 0)
        
        completion()
    }
    
    func fetchLocalData(completion: @escaping ()->Void) {
        
        let task = {
            self.localMomentEntities = []
            self.loadDataFromLocal {
                completion()
            }
        }
        
        if remoteMomentEntities == nil {
            fetchRemoteData {
                task()
            }
        } else {
            task()
        }
    }
    
    func fetchMoreLocalData(completion: @escaping ()->Void) {
        loadDataFromLocal {
            completion()
        }
    }
}
