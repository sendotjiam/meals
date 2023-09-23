//
//  LabelCollectionViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit
import SnapKit

final class HeaderReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderReusableView"
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.4)
        label.text = "Starts with letter A"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

extension HeaderReusableView {
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
    }
}
