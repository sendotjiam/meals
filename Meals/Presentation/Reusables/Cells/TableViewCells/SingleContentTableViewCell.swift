//
//  SingleContentTableViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit

final class SingleContentTableViewCell: UITableViewCell {
    
    static let identifier = "SingleContentTableViewCell"
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.6)
        label.text = "Instructions"
        return label
    }()
    
    private lazy var contentLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with title: String, content: String) {
        titleLabel.text = title
        contentLabel.attributedText = NSMutableAttributedString(string: content)
    }
    
}

extension SingleContentTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        titleLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        contentLabel.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        })
    }
}
