//
//  UIScrollView+Reload.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import UIKit

extension UICollectionView {
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}

extension UITableView {
    func reload() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}
