//
//  MealListViewController.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MealListViewController: UIViewController {
    
    private lazy var collectionView = makeCollectionView()
    private lazy var loadingIndicatorView = {
        let view = LoadingView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        view.roundCorner(with: 10)
        return view
    }()
    private lazy var fab = {
        let button = UIButton()
        button.setTitle("Choose start letter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.roundCorner(with: 10)
        button.backgroundColor = .white
        button.addBorder(with: 1, color: UIColor.systemBlue.cgColor)
        button.addTarget(self, action: #selector(didTapFab), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: MealListViewModelProtocol
    private let bag = DisposeBag()
    private let wireframe = MealListWireframe()
    private var selectedLetter = "A"
    
    init(with viewModel: MealListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        viewModel.onLoad(with: selectedLetter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    
}

extension MealListViewController {
    private func setupNav() {
        title = "Meals"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(didTapSearch))
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.identifier)
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier)
        
        view.addSubview(collectionView)
        view.addSubview(loadingIndicatorView)
        view.addSubview(fab)
        
        fab.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        })
        collectionView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        })
        loadingIndicatorView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        })
        
    }
    
    private func setupBindings() {
        viewModel.dataSubject
            .subscribe({ [weak self] event in
                guard let self else { return }
                switch event {
                case .next(_):
                    self.collectionView.reload()
                case .error(let error):
                    guard let error = error as? BaseErrors else {
                        return
                    }
                    print(error)
                    switch (error) {
                    default:
                        self.wireframe.showAlert(from: self, title: "Failed", body: "Failed to get meals with the letter 'A', please try again later.")
                    }
                case .completed:
                    return
                }
            }).disposed(by: bag)
        
        viewModel.loadingSubject
            .asObservable()
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] isLoading in
                guard let self else { return }
                self.loadingIndicatorView.isLoading = isLoading
                self.loadingIndicatorView.isHidden = !isLoading
                self.view.isUserInteractionEnabled = !isLoading
            })
            .disposed(by: bag)
    }
    
    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 60, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
    
    @objc private func didTapFab() {
        wireframe.showConfigScreen(from: self, selected: selectedLetter)
    }
    
    @objc private func didTapSearch() {
        SearchWireframe().show(from: self)
    }
}

extension MealListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.displayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.identifier,
                                                            for: indexPath) as? ThumbnailCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(with: viewModel.displayData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 8
        return CGSize(width: width, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as? HeaderReusableView
        headerView?.configure(title: "All meals starts with letter \(selectedLetter)")
        return headerView ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = viewModel.displayData[indexPath.row].id
        MealDetailWireframe().show(from: self, with: id)
    }
}

extension MealListViewController: MealListConfigDelegate {
    func didChoose(letter: String) {
        selectedLetter = letter
        viewModel.onLoad(with: letter)
    }
}
