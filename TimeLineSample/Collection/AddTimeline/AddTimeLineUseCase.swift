//
//  AddTimeLineUseCase.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/31/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseAddTimeLineUseCase : AddTimeLineUseCase {
    func saveNewTimeline(timeline: TimelineViewModel) -> Observable<Bool> {
        print("FAKE API REQUEST TO SAVE NEW TIMELINE")
        return Observable.just(true)
    }
}
