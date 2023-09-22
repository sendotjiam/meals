//
//  ThumbnailCollectionViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit
import Kingfisher
import SnapKit

final class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ThumbnailCollectionViewCell"
    
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.roundCorner(with: 10)
        return imageView
    }()
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = "Pie"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MealModel) {
        let url = URL(string: model.thumbnail)
        titleLabel.text = "\(model.name)"
        imageView.kf.setImage(with: url,
                              options: [
                                .transition(.fade(0.3)),
                                .cacheOriginalImage
                              ])
    }
}

extension ThumbnailCollectionViewCell {
    private func setupViews() {
        backgroundColor = .white
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.layer.masksToBounds = true
        imageView.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp_topMargin).offset(-8)
        })
        titleLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        })
    }
}
