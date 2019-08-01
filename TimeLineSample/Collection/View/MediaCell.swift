//
//  MediaCell.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MediaCell : UICollectionViewCell {
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
