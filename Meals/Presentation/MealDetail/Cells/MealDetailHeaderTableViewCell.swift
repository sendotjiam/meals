//
//  MealDetailHeaderTableViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit
import Kingfisher

protocol MealDetailHeaderDelegate: AnyObject {
    func didTapImage()
}

final class MealDetailHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "MealDetailHeaderTableViewCell"
    
    private lazy var posterImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private lazy var nameLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var categoryLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var categoryView = {
        let view = UIView(frame: .zero)
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        })
        view.roundCorner(with: 8)
        view.backgroundColor = .systemOrange
        return view
    }()
    
    
    private lazy var areaLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.6)
        return label
    }()
    
    weak var delegate: MealDetailHeaderDelegate?
    
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
    
    func configure(with model: MealModel) {
        let url = URL(string: model.thumbnail)
        posterImageView.kf.setImage(with: url,
                                    options: [
                                        .transition(.fade(0.3)),
                                        .cacheOriginalImage
                                    ])
        nameLabel.text = model.name
        areaLabel.text = "\(model.area) cuisines"
        categoryView.backgroundColor = CategoryBadgeColors.generateColor(from: model.category)
        categoryLabel.text = model.category
    }
    
}

extension MealDetailHeaderTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        [posterImageView, nameLabel, categoryView, areaLabel].forEach({ [weak self] view in
            self?.contentView.addSubview(view)
        })
        let screenWidth = UIScreen.main.bounds.width
        posterImageView.snp.makeConstraints({ make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(screenWidth)
            make.width.equalTo(screenWidth).priority(.required)
        })
        nameLabel.snp.makeConstraints({ make in
            make.top.equalTo(posterImageView.snp_bottomMargin).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        areaLabel.snp.makeConstraints({ make in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(24).priority(.high)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        categoryView.snp.makeConstraints({ make in
            make.top.equalTo(areaLabel.snp_bottomMargin).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        })
    }
    
    @objc private func didTapImage() {
        delegate?.didTapImage()
    }
}
