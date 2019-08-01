//
//  CollectionTimeLineController.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let collectionCellId = "collectionCellId"
class CollectionTimeLineController : UIViewController {
    let disposeBag = DisposeBag()
    init(viewModel: CollectionTimeLineViewModel) {
        super.init(nibName: "CollectionTimeLineController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var reloadMessageLabel: UILabel!
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet weak var reloadMessageHeight: NSLayoutConstraint!
    
    var viewModel : CollectionTimeLineViewModel!
    var content = [TimelineViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadMessageHeight.constant = 0.0
        setupNavigationBar()
        timelineTableView.register(CollectionViewCell.self, forCellReuseIdentifier: collectionCellId)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        content = ContentService.generateContent(count: 100)
        setupBinding()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
    }
    
    func showReloadDataMessage(message: String) {
        reloadMessageLabel.text = message
        reloadMessageHeight.constant = 50.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.reloadMessageLabel.text = ""
            self?.reloadMessageHeight.constant = 0.0
        }
    }
    
    func setupBinding() {
        let input = CollectionTimeLineViewModel.Input(addTimelineTrigger: navigationItem.rightBarButtonItem!.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.dataUpdate.drive(rx.reloadTimeline).disposed(by: disposeBag)
    }
}

extension CollectionTimeLineController : UITableViewDelegate {
    
}

extension CollectionTimeLineController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: collectionCellId, for: indexPath) as? CollectionViewCell
        cell?.viewModel = content[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension Reactive where Base : CollectionTimeLineController {
    var reloadTimeline : Binder<String> {
        return Binder<String>(base, binding: { (vc, message) in
            vc.showReloadDataMessage(message: message)
        })
    }
}
