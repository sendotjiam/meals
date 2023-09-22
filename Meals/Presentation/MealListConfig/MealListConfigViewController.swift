//
//  MealListConfigViewController.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit
import SnapKit

protocol MealListConfigDelegate: AnyObject {
    func didChoose(letter: String)
}

final class MealListConfigViewController: UIViewController {

    private lazy var tableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        return tableView
    }()
    
    private let letters =
        ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    weak var delegate: MealListConfigDelegate?
    private let selected : String
    
    init(selected: String) {
        self.selected = selected
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension MealListConfigViewController {
    private func setupViews() {
        title = "Choose the letter"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        })
    }
}

extension MealListConfigViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = letters[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didChoose(letter: letters[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}
