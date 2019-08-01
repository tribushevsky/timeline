//
//  ContentService.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

class ContentService {
    class func generateContent(count: Int) -> [TimelineViewModel] {
        var content = [TimelineViewModel]()
        
        for index in 0..<count {
            let mediaCount = Int.random(in: 1...7)
            var media = [UIImage]()
            for mediaIndex in 1...mediaCount {
                media.append(UIImage(named: String(mediaIndex))!)
            }
            
            let item = TimelineViewModel(text: String(index),
                                         media: media)
            
            content.append(item)
        }
        
        return content
    }
}
