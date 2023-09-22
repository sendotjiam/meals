//
//  MealDetailWireframe.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//


import UIKit

final class MealDetailWireframe {
    
    init() {}
    
    func create(id: String) -> MealDetailViewController {
        let vm = MealDetailViewModel(with: id)
        let vc = MealDetailViewController(with: vm)
        return vc
    }
    
    func show(from: UIViewController, with id: String) {
        let vc = create(id: id)
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
