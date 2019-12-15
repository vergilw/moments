//
//  MomentsViewController.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

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

        navigationItem.title = "Moments"
        
        initContentView()
        initConstraints()
        addNotificationObservers()
        
        viewModel.fetchLocalData {
            self.tableView.reloadData()
            self.reloadTableViewRefreshControl()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        tableView.mj_header.beginRefreshing()
    }

    // MARK: - ============= Initialize View =============
    fileprivate func initContentView() {
        
        let task = { [weak self] in
            self?.tableView.reloadData()
            self?.reloadTableViewRefreshControl()
        }
        
        tableView.estimatedRowHeight = 0
        tableView.register(MomentsBaseRowCell.self, forCellReuseIdentifier: MomentsBaseRowCell.className())
        tableView.register(MomentsImageRowCell.self, forCellReuseIdentifier: MomentsImageRowCell.className())
        tableView.register(MomentsMultiImageRowCell.self, forCellReuseIdentifier: MomentsMultiImageRowCell.className())
        tableView.register(MomentsCommentRowCell.self, forCellReuseIdentifier: MomentsCommentRowCell.className())
        tableView.register(MomentsSeparatorCell.self, forCellReuseIdentifier: MomentsSeparatorCell.className())
        tableView.mj_header = MJRefreshStateHeader(refreshingBlock: { [weak self] in
            self?.viewModel.fetchLocalData {
                self?.tableView.mj_header.endRefreshing()
                task()
            }
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self?.viewModel.fetchMoreLocalData(completion: {
                self?.tableView.mj_footer.endRefreshing()
                task()
            })
        })
        tableView.mj_footer.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubviews([tableView])
    }
    
    // MARK: - ============= Constraints =============
    fileprivate func initConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let inset = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets
        tableView.contentInset = inset ?? UIEdgeInsets.zero
        tableView.contentInset.top = 0
    }
    
    // MARK: - ============= Notification =============
    fileprivate func addNotificationObservers() {
        
    }
    
    // MARK: - ============= Request =============
    
    // MARK: - ============= Reload =============
    @objc func reload() {
        
    }
    
    func reloadTableViewRefreshControl() {
        if viewModel.dataHasMore ?? false {
            tableView.mj_footer.isHidden = false
            tableView.mj_footer.resetNoMoreData()
            
        } else {
            tableView.mj_footer.isHidden = true
        }
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
        return viewModel.packagedEntities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let entity = viewModel.packagedEntities?[indexPath.row] else { return 0 }
        
        if let _ = entity as? String {
            return 16
        } else if let commentEntity = entity as? CommentEntity {
            return tableView.fd_heightForCell(withIdentifier: MomentsCommentRowCell.className(), cacheBy: indexPath) { (cell) in
                if let cell = cell as? MomentsCommentRowCell {
                    cell.setup(entity: commentEntity)
                }
            }
        } else {
            guard let entity = entity as? MomentEntity else { return 0 }
            
            if entity.images?.count ?? 0 > 1 {
                return tableView.fd_heightForCell(withIdentifier: MomentsMultiImageRowCell.className(), cacheBy: indexPath) { (cell) in
                    if let cell = cell as? MomentsMultiImageRowCell {
                        cell.setup(entity: entity)
                    }
                }
            } else if entity.images?.count ?? 0 > 0 {
                return tableView.fd_heightForCell(withIdentifier: MomentsImageRowCell.className(), cacheBy: indexPath) { (cell) in
                    if let cell = cell as? MomentsImageRowCell {
                        cell.setup(entity: entity)
                    }
                }
            } else {
                return tableView.fd_heightForCell(withIdentifier: MomentsBaseRowCell.className(), cacheBy: indexPath) { (cell) in
                    if let cell = cell as? MomentsBaseRowCell {
                        cell.setup(entity: entity)
                    }
                }
            }
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let entity = viewModel.packagedEntities?[indexPath.row] else { return UITableViewCell() }
        
        if let _ = entity as? String {
            let cell = tableView.dequeueReusableCell(withIdentifier: MomentsSeparatorCell.className(), for: indexPath) as! MomentsSeparatorCell
            return cell
        } else if let commentEntity = entity as? CommentEntity {
            let cell = tableView.dequeueReusableCell(withIdentifier: MomentsCommentRowCell.className(), for: indexPath) as! MomentsCommentRowCell
            cell.setup(entity: commentEntity)
            return cell
        } else {
            guard let entity = entity as? MomentEntity else { return UITableViewCell() }
            
            if entity.images?.count ?? 0 > 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MomentsMultiImageRowCell.className(), for: indexPath) as! MomentsMultiImageRowCell
                cell.setup(entity: entity)
                return cell
            } else if entity.images?.count ?? 0 > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: MomentsImageRowCell.className(), for: indexPath) as! MomentsImageRowCell
                cell.setup(entity: entity)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MomentsBaseRowCell.className(), for: indexPath) as! MomentsBaseRowCell
                cell.setup(entity: entity)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
