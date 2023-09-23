//
//  MealFooterTableViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit

protocol MealDetailFoooterDelegate : AnyObject {
    func didTapLink(url: URL)
}

final class MealDetailFooterTableViewCell: UITableViewCell {

    static let identifier = "MealDetailFooterTableViewCell"
    
    private lazy var sourcesTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Sources: "
        label.textColor = .black.withAlphaComponent(0.6)
        return label
    }()
    
    private lazy var tagsTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.6)
        label.text = "Tags: "
        return label
    }()
    
    private lazy var tagsLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var sourceLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .link
        label.isUserInteractionEnabled = true
        let sourceTapped = UITapGestureRecognizer(target: self, action: #selector(didTapSource))
        label.addGestureRecognizer(sourceTapped)
        return label
    }()
    
    private lazy var youtubeLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .link
        label.isUserInteractionEnabled = true
        let youtubeTapped = UITapGestureRecognizer(target: self, action: #selector(didTapYoutube))
        label.addGestureRecognizer(youtubeTapped)
        return label
    }()
    
    private var model : MealModel?
    weak var delegate: MealDetailFoooterDelegate?
    
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
        self.model = model
        if model.tags.isEmpty {
            tagsTitleLabel.isHidden = true
            tagsLabel.isHidden = true
        } else {
            tagsLabel.text = model.tags.split(separator: ",").joined(separator: ", ")
        }
        if model.source.isEmpty && model.youtube.isEmpty {
            sourceLabel.isHidden = true
            youtubeLabel.isHidden = true
            sourcesTitleLabel.isHidden = true
        } else {
            if !model.source.isEmpty {
                sourceLabel.text = " - \(model.source)"
            }
            if !model.youtube.isEmpty {
                youtubeLabel.text = " - \(model.youtube)"
            }
        }
    }
}

extension MealDetailFooterTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        [tagsTitleLabel, tagsLabel, sourcesTitleLabel, sourceLabel, youtubeLabel].forEach({ [weak self] view in
            self?.contentView.addSubview(view)
        })
        tagsTitleLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        })
        tagsLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(tagsTitleLabel.snp_trailingMargin).offset(8).priority(.low)
            make.trailing.equalToSuperview().offset(-16)
        })
        sourcesTitleLabel.snp.makeConstraints({ make in
            make.top.equalTo(tagsTitleLabel.snp_bottomMargin).offset(16).priority(.high)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        sourceLabel.snp.makeConstraints({ make in
            make.top.equalTo(sourcesTitleLabel.snp_bottomMargin).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        youtubeLabel.snp.makeConstraints({ make in
            make.top.equalTo(sourceLabel.snp_bottomMargin).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        })
    }
    
    @objc private func didTapYoutube() {
        guard let model = model,
              let url = URL(string: model.youtube) else {
            return
        }
        delegate?.didTapLink(url: url)
    }
    
    @objc private func didTapSource() {
        guard let model = model,
              let url = URL(string: model.source) else {
            return
        }
        delegate?.didTapLink(url: url)
    }
}

