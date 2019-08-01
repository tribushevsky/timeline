//
//  CollectionTimeLineProtocol.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol CollectionTimeLineContext {
    var timelineTitle: String { get }
}

public protocol CollectionTimeLineUseCase {
    func timelinePost(count: Int, offset: Int)
}

public protocol CollectionTimeLineNavigator {
    func back()
    func openPost(post: TimelineViewModel) -> Observable<Void>
    func addTimeline() -> Observable<Bool>
}


