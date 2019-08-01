//
//  CollectionTimeLineNavigator.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseCollectionTimeLineNavigator : BaseNavigator, CollectionTimeLineNavigator {
    
    func addTimeline() -> Observable<Bool> {
        guard let navigationController = navigationController else {
            let error = NSError(domain: "Empty navigation controller", code: 0, userInfo: [:])
            return Observable.error(error)
        }
        
        let context = BaseAddTimeLineContext(defaultText: "Hello world! Default text for 'Add timeline' screen")
        let usecase = BaseAddTimeLineUseCase()
        let navigator = BaseAddTimeLineNavigator(navigationController: navigationController, rootNavigator: nil)
        let viewModel = AddTimelineViewModel(context: context, useCase: usecase, navigator: navigator)
        let controller = AddTimelineController.create(viewModel: viewModel)
        
        return navigationController.rx.push(controller, animated: true)
            .map { navigator }
            .flatMapLatest { $0.completion.asObservable() }
            .debug("|_|OPEN")
    }
    
    func openPost(post: TimelineViewModel) -> Observable<Void> {
        return Observable.just(())
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
