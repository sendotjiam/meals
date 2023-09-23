//
//  PanZoomImageView.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit
import Kingfisher

final class PanZoomImageView: UIScrollView {
    
    private lazy var imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        })
        minimumZoomScale = 1
        maximumZoomScale = 3
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
    }
    
    func configure(imageUrl: URL?) {
        imageView.kf.setImage(with: imageUrl,
                              options: [
                                .transition(.fade(0.3)),
                                .cacheOriginalImage
                              ])
    }
}

extension PanZoomImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
