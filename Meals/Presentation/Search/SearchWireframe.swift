//
//  SearchWireframe.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit

final class SearchWireframe {
    
    init() {
        
    }
    
    func create() -> SearchViewController {
        let vm = SearchViewModel()
        let vc = SearchViewController(with: vm)
        return vc
    }
    
    func show(from: UIViewController) {
        let vc = create()
        from.navigationController?.pushViewController(vc, animated: true)
    }

    func showAlert(from: UIViewController, title: String, body: String) {
        let alert = from.createAlert(title, body, nil)
        from.present(alert, animated: true)
    }
}
