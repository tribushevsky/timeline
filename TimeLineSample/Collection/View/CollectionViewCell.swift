//
//  CollectionViewCell.swift
//  TimeLineSample
//
//  Created by Vladimir Tribushevsky on 7/28/19.
//  Copyright © 2019 Vladimir Tribushevsky. All rights reserved.
//

import Foundation
import UIKit

fileprivate let mediaCellId = "mediaCellId"

class CollectionViewCell : UITableViewCell {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let titleLabel = UILabel()
    
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
        collectionView.contentOffset = .zero
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: mediaCellId)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(250.0)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.right.bottom.left.equalToSuperview()
        }
    }
    
    private func fillView() {
        titleLabel.text = viewModel?.text
        collectionView.reloadData()
    }
}

extension CollectionViewCell : UICollectionViewDelegate {
    
}

extension CollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.media.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaCellId, for: indexPath) as? MediaCell
        cell?.imageView.image = viewModel?.media[indexPath.item]
        
        return cell ?? UICollectionViewCell()
    }
}

extension CollectionViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
