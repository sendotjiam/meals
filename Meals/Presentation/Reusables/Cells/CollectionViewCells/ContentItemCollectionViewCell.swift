//
//  ContentItemCollectionViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit

final class ContentItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ThumbnailCollectionViewCell"

    private lazy var contentLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Pie"
        label.numberOfLines = 0
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
    
    func configure(num: Int, content: String) {
        contentLabel.text = " \(num). \(content)"
    }
}

extension ContentItemCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
    }
}
