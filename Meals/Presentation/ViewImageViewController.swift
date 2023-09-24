//
//  ViewImageViewController.swift
//  Meals
//
//  Created by Sendo Tjiam on 24/09/23.
//

import UIKit
import SnapKit
import Kingfisher

final class ViewImageViewController: UIViewController {
    
    private lazy var imageView = {
        let imageView = PanZoomImageView()
        return imageView
    }()
    
    private lazy var buttonImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "multiply.circle.fill")
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(imageView)
        view.addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        let screenWidth = UIScreen.main.bounds.width
        imageView.snp.makeConstraints({ make in
            make.width.equalTo(screenWidth)
            make.height.equalTo(screenWidth)
            make.center.equalToSuperview()
        })
    }
    
    func configure(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        imageView.configure(imageUrl: url)
    }

    @objc private func didTapButton() {
        dismiss(animated: true)
    }
}
