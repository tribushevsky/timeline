//
//  AddTimelineViewModel.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BaseAddTimeLineContext : AddTimeLineContext {
    let defaultText: String
}

class AddTimelineViewModel : ViewModelType {
    
    public let context: AddTimeLineContext
    public let useCase: AddTimeLineUseCase
    public let navigator: AddTimeLineNavigator
    
    init(context: AddTimeLineContext, useCase: AddTimeLineUseCase, navigator: AddTimeLineNavigator) {
        self.context = context
        self.useCase = useCase
        self.navigator = navigator
    }
    
    struct Input {
        let saveTrigger: Driver<TimelineViewModel>
        let closeTrigger: Driver<Void>
    }
    
    struct Output {
        let support: Driver<Void>
    }
    
    func transform(input: AddTimelineViewModel.Input) -> AddTimelineViewModel.Output {
        let saveNewTimeline = input.saveTrigger.flatMapLatest { [weak self] (timeline) -> Driver<Bool> in
            guard let wself = self else {
                return Driver.empty()
            }
            
            return wself.useCase.saveNewTimeline(timeline: timeline).asDriver(onErrorJustReturn: false).debug("|_|SAVE")
        }.do(onNext: { [weak self] (success) in
            self?.navigator.complete(event: success)
        })
        
        return Output(support: saveNewTimeline.map { _ in })
    }
}
