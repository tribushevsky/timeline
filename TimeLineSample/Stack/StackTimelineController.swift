//
//  StackTimelineController.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

fileprivate let stackCellId = "stackCellId"
class StackTimelineController : UIViewController {
    @IBOutlet weak var timelineTableView: UITableView!
    var content = [TimelineViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        timelineTableView.register(StackViewCell.self, forCellReuseIdentifier: stackCellId)
        timelineTableView.delegate = self
        timelineTableView.dataSource = self
        content = ContentService.generateContent(count: 100)
    }
}

extension StackTimelineController : UITableViewDelegate {
    
}

extension StackTimelineController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: stackCellId, for: indexPath) as? StackViewCell
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
