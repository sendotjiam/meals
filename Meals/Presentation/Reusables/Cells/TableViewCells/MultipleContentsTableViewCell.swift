//
//  TitleContentListTableViewCell.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit
import SnapKit

final class MultipleContentsTableViewCell: UITableViewCell {

    static let identifier = "MultipleContentsTableViewCell"
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black.withAlphaComponent(0.6)
        label.text = "Instructions"
        return label
    }()
    
    private lazy var collectionView = makeCollectionView()
    
    private var contents = [String]()
    
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
    
    func configure(with title: String, contents: [String]) {
        titleLabel.text = title
        self.contents = contents
        collectionView.reload()
    }

}

extension MultipleContentsTableViewCell {
    private func setupViews() {
        selectionStyle = .none
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ContentItemCollectionViewCell.self, forCellWithReuseIdentifier: ContentItemCollectionViewCell.identifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        titleLabel.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
        collectionView.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        })
    }
    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 60, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
}

extension MultipleContentsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        contents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentItemCollectionViewCell.identifier, for: indexPath) as? ContentItemCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(num: indexPath.row + 1, content: contents[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 16)
    }
}
