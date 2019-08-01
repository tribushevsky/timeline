//
//  BaseProtocols.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/30/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype Context
    
    var context: Context { get }
    
    func transform(input: Input) -> Output
}

protocol Navigator {
    var rootNavigator: Navigator? { get }
}
