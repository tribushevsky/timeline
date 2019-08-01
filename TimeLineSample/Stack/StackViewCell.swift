//
//  StackViewCell.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

class StackViewCell : UITableViewCell {
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let scrollView = UIScrollView()
    
    var viewModel: TimelineViewModel? {
        didSet {
            fillView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.contentOffset = .zero
    }
    
    private func setupView() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.height.equalTo(250.0)
            make.left.top.right.equalToSuperview()
        }
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().priority(.low)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
    }
    
    private func fillView() {
        cleanMediaView()
        titleLabel.text = viewModel?.text
        if let media = viewModel?.media {
            for item in media {
                let imageView = UIImageView(image: item)
                imageView.snp.makeConstraints { (make) in
                    make.width.equalTo(350.0)
                }
                stackView.addArrangedSubview(imageView)
            }
        }
    }
    
    private func cleanMediaView() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
        }
    }
}
