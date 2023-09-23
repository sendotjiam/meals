//
//  UIViewController+Height.swift
//  Meals
//
//  Created by Sendo Tjiam on 23/09/23.
//

import UIKit

extension UIViewController {
    var statusBarHeight : CGFloat {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height  ?? 0
    }
    
    var navBarHeight: CGFloat {
        44.0
    }
}
