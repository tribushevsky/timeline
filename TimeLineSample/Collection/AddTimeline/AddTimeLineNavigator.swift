//
//  AddTimeLineNavigator.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/31/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxCocoa

class BaseAddTimeLineNavigator : BaseNavigator, AddTimeLineNavigator {
    let cancelation: PublishRelay<Void>  = PublishRelay()
    let completion: PublishRelay<Bool> = PublishRelay()
    
    func complete(event: Bool) {
        completion.accept(event)
    }
}
