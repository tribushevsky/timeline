//
//  TimelineViewModel.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

public class TimelineViewModel {
    let text: String
    let media: [UIImage]
    
    init(text: String, media: [UIImage]) {
        self.text = text
        self.media = media
    }
}
