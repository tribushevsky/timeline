//
//  UINavigationController+Rx.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 8/1/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import RxSwift

extension Reactive where Base: UINavigationController {
    
    func push(_ viewController: UIViewController, animated: Bool) -> Observable<Void> {
        guard base.viewIfLoaded?.window != nil else {
            base.pushViewController(viewController, animated: false)
            return .just(())
        }
        return didShow.take(1).map { _ in }.do(onSubscribed: { () in
            self.base.pushViewController(viewController, animated: animated)
        })
    }
    
    func pop(animated: Bool) -> Observable<Void> {
        guard base.topViewController != base.viewControllers.first else {
            return .just(())
        }
        guard base.viewIfLoaded?.window != nil else {
            base.popViewController(animated: false)
            return .just(())
        }
        return didShow.take(1).map { _ in }.do(onSubscribed: { () in
            self.base.popViewController(animated: animated)
        })
    }
    
    func popToRoot(animated: Bool) -> Observable<Void> {
        guard base.topViewController != base.viewControllers.first else {
            return .just(())
        }
        guard base.viewIfLoaded?.window != nil else {
            base.popToRootViewController(animated: false)
            return .just(())
        }
        return didShow.take(1).map { _ in }.do(onSubscribed: { () in
            self.base.popToRootViewController(animated: animated)
        })
    }
    
    func popTo(_ viewController: UIViewController, animated: Bool) -> Observable<Void> {
        guard base.viewControllers.contains(viewController), base.topViewController != viewController else {
            return .just(())
        }
        guard base.viewIfLoaded?.window != nil else {
            base.popToViewController(viewController, animated: false)
            return .just(())
        }
        return didShow.take(1).map { _ in }.do(onSubscribed: { () in
            self.base.popToViewController(viewController, animated: animated)
        })
    }
}
