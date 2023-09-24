//
//  BadgeColors.swift
//  Meals
//
//  Created by Sendo Tjiam on 24/09/23.
//

import UIKit

struct CategoryBadgeColors {
    
    static func generateColor(from name: String) -> UIColor {
        switch name {
        case "Beef", "Chicken", "Lamb", "Pork", "Goat":
            return .systemRed
        case "Vegan", "Vegetarian":
            return .systemGreen
        case "Breakfast", "Starter", "Side":
            return .gray
        case "Seafood":
            return .systemBlue
        case "Miscellaneous", "Pasta":
            return .systemOrange
        case "Dessert":
            return .systemBrown
        default:
            return .systemOrange
        }
    }
    
}
