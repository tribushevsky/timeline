//
//  AddTimelineProtocol.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AddTimeLineContext {
    var defaultText: String { get }
}

protocol AddTimeLineUseCase {
    func saveNewTimeline(timeline: TimelineViewModel) -> Observable<Bool>
}

protocol AddTimeLineNavigator {
    var cancelation: PublishRelay<Void> { get }
    var completion: PublishRelay<Bool> { get }
    
    func complete(event: Bool)
}

