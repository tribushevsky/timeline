//
//  CollectionTimeLineViewModel.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BaseCollectionTimeLineContext : CollectionTimeLineContext {
    let timelineTitle: String
}

public class CollectionTimeLineViewModel : ViewModelType {
    public let context: CollectionTimeLineContext
    public let useCase: CollectionTimeLineUseCase
    public let navigator: CollectionTimeLineNavigator
    
    init(context: CollectionTimeLineContext, useCase: CollectionTimeLineUseCase, navigator: CollectionTimeLineNavigator) {
        self.context = context
        self.useCase = useCase
        self.navigator = navigator
    }
    
    public struct Input {
        let addTimelineTrigger: Driver<Void>
    }
    
    public struct Output {
        let dataUpdate : Driver<String>
        let support : Driver<Bool>
    }
    
    public func transform(input: Input) -> Output {
        
        let addTimeline = input.addTimelineTrigger.flatMapLatest { [weak self] (_) -> Driver<Bool> in
            guard let wself = self else {
                return Driver.empty()
            }
            
            return wself.navigator.addTimeline()
                .asDriver(onErrorJustReturn: false)
                .do(onNext: { [weak self] (_) in self?.navigator.back() })
        }
        
        let updateData = addTimeline.filter { $0 }
            .map {_ in return "Data will reload because a new post was added." }
        
        return Output(dataUpdate: updateData,
                      support: addTimeline)
    }
}
