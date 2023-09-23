//
//  MealDetailViewController.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SafariServices

final class MealDetailViewController: UIViewController {
    
    private enum SectionType {
        case header, instructions, ingredients, footer
    }
    
    private lazy var tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var loadingIndicatorView = {
        let view = LoadingView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isHidden = true
        view.roundCorner(with: 10)
        return view
    }()
    
    private let wireframe = MealDetailWireframe()
    private let sections : [SectionType] = [
        .header, .instructions, .ingredients, .footer
    ]
    private let bag = DisposeBag()
    private let viewModel: MealDetailViewModelProtocol
    
    init(with viewModel: MealDetailViewModelProtocol) {
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
        viewModel.onLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

extension MealDetailViewController {
    private func setupViews() {
        view.backgroundColor = .red
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MealDetailHeaderTableViewCell.self, forCellReuseIdentifier: MealDetailHeaderTableViewCell.identifier)
        tableView.register(SingleContentTableViewCell.self, forCellReuseIdentifier: SingleContentTableViewCell.identifier)
        tableView.register(MultipleContentsTableViewCell.self, forCellReuseIdentifier: MultipleContentsTableViewCell.identifier)
        tableView.register(MealDetailFooterTableViewCell.self, forCellReuseIdentifier: MealDetailFooterTableViewCell.identifier)
        
        view.addSubview(loadingIndicatorView)
        view.addSubview(tableView)
        
        loadingIndicatorView.snp.makeConstraints({ make in
            make.center.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(60)
        })
        tableView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(-(navBarHeight + statusBarHeight))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
    
    private func setupBindings() {
        viewModel.dataSubject
            .subscribe({ [weak self] event in
                guard let self else { return }
                switch event {
                case .next(_):
                    self.tableView.reload()
                case .error(let error):
                    guard let error = error as? BaseErrors else {
                        return
                    }
                    print(error)
                    switch (error) {
                    default:
                        self.wireframe.showAlert(from: self, title: "Failed", body: "Failed to get meal information, please try again later.", handler: { _ in
                            self.viewModel.onLoad()
                        })
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
    
    func openSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
}

extension MealDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealDetailHeaderTableViewCell.identifier, for: indexPath) as? MealDetailHeaderTableViewCell,
                  let model = viewModel.displayData else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .instructions:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleContentTableViewCell.identifier, for: indexPath) as? SingleContentTableViewCell,
                  let instructions = viewModel.displayData?.instructions,
                  !instructions.isEmpty else {
                return UITableViewCell()
            }
            cell.configure(with: "Instructions", content: instructions)
            return cell
        case .ingredients:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MultipleContentsTableViewCell.identifier, for: indexPath) as? MultipleContentsTableViewCell,
                  let ingredients = viewModel.displayData?.ingredients,
                  !ingredients.isEmpty else {
                return UITableViewCell()
            }
            cell.configure(with: "Ingredients", contents: ingredients)
            return cell
        case .footer:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MealDetailFooterTableViewCell.identifier, for: indexPath) as? MealDetailFooterTableViewCell,
                  let model = viewModel.displayData else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .ingredients:
            guard let ingredients = viewModel.displayData?.ingredients else {
                return UITableView.automaticDimension
            }
            return CGFloat(30 * (ingredients.count))
        default:
            return UITableView.automaticDimension
        }
    }
}

extension MealDetailViewController: MealDetailFoooterDelegate {
    func didTapLink(url: URL) {
        openSafariVC(url : url)
    }
}

extension MealDetailViewController : SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
