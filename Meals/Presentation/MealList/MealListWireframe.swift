//
//  MealListWireframe.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit

final class MealListWireframe {
    
    init() {}
    
    func create() -> MealListViewController {
        let vm = MealListViewModel()
        let vc = MealListViewController(with: vm)
        return vc
    }
    
    func showAlert(from: UIViewController, title: String, body: String) {
        let alert = from.createAlert(title, body, nil)
        from.present(alert, animated: true)
    }
    
    func showConfigScreen(from: UIViewController, selected: String) {
        let vc = MealListConfigViewController(selected: selected)
        vc.delegate = from as? MealListViewController
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
