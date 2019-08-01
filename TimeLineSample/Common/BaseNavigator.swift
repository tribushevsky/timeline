//
//  BaseNavigator.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

public class BaseNavigator: Navigator {
    
    let rootNavigator: Navigator?
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController, rootNavigator: Navigator? = nil) {
        self.rootNavigator = rootNavigator
        self.navigationController = navigationController
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
}
