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

final class MealDetailViewController: UIViewController {

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
    }
}
