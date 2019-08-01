//
//  StartController.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

class StartController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
            let context = BaseCollectionTimeLineContext(timelineTitle: "Timeline Sample")
            let navigator = BaseCollectionTimeLineNavigator(navigationController: navigationController)
            let useCase = BaseCollectionTimeLineUseCase()
            let viewModel = CollectionTimeLineViewModel(context: context, useCase: useCase, navigator: navigator)
            let timelineController = CollectionTimeLineController(viewModel: viewModel)
            
            navigationController.pushViewController(timelineController, animated: true)
        }
    }
}
