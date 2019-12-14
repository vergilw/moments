//
//  MomentsViewController.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

class MomentsViewController: UIViewController {

    fileprivate var viewModel: MomentsViewModel = {
        let viewModel = MomentsViewModel()
        return viewModel
    }()
    
    fileprivate var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        if #available(iOS 11, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
        }
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - ============= Liftcycle =============
    override func viewDidLoad() {
        super.viewDidLoad()

        initContentView()
        initConstraints()
        addNotificationObservers()
        
        viewModel.fetchLocalData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        tableView.estimatedRowHeight = 90
//        tableView.register(CourseCatalogueCell.self, forCellReuseIdentifier: CourseCatalogueCell.className())
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubviews([tableView])
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - ============= Notification =============
    fileprivate func addNotificationObservers() {
        
    }
    
    // MARK: - ============= Request =============
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        
    }
    
    // MARK: - ============= Action =============
    
    // MARK: - ============= Public =============
    
    // MARK: - ============= Private =============
}


// MARK: - ============= Extension: UITableViewDataSource and UITableViewDelegate =============
extension MomentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.localMomentEntities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className(), for: indexPath) as! UITableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
