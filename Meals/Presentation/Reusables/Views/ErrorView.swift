//
//  ErrorView.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit

protocol ErrorViewDelegate: AnyObject {
    func didTapButton()
}

final class ErrorView: UIView {
    
    private lazy var imageView = {
        let imageView = UIImageView(image: UIImage(named: "empty"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel = {
       let label = UILabel()
        label.text = "Unable to get the information that you wanted, please try again later."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .black.withAlphaComponent(0.6)
        label.textAlignment =  .center
        return label
    }()
    
    private lazy var actionButton = {
        let button = UIButton()
        button.roundCorner(with: 10)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate : ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(actionButton)
        
        imageView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        })
        
        titleLabel.snp.makeConstraints({ make in
            make.top.equalTo(imageView.snp_bottomMargin).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        })
        
        actionButton.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp_bottomMargin).offset(32)
            make.bottom.equalToSuperview()
        })
    }
    
    func configure(buttonTitle: String) {
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    @objc private func didTapButton() {
        delegate?.didTapButton()
    }
}
