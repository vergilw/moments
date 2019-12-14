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
    
    func fetchRemoteData(completion: @escaping ()->Void) {
        MomentsProvider.request(.moments, completion: ResponseService.sharedInstance.response(completion: { (code,JSON) in
            
            if let moments = JSON {
                if let entities = [MomentEntity].deserialize(from: moments) as? [MomentEntity] {
                    self.remoteMomentEntities = entities
                }
            }
            
            completion()
        }))
    }
    
    func loadDataFromLocal() {
        guard let entities = self.remoteMomentEntities, entities.count > self.localMomentEntities?.count ?? 0 else { return }
        
        let startIndex = self.localMomentEntities?.count ?? 0
        self.localMomentEntities?.append(contentsOf: Array(entities[startIndex..<startIndex+self.dataPerPage]))
        
        if entities.count > self.localMomentEntities?.count ?? 0 {
            self.dataHasMore = true
        } else {
            self.dataHasMore = false
        }
        
        print(self.localMomentEntities as Any)
    }
    
    func fetchLocalData() {
        
        let task = {
            self.localMomentEntities = []
            self.loadDataFromLocal()
        }
        
        if remoteMomentEntities == nil {
            fetchRemoteData {
                task()
            }
        } else {
            task()
        }
    }
    
    func fetchMoreLocalData() {
        loadDataFromLocal()
    }
}
