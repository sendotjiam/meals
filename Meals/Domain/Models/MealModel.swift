//
//  MealModel.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation

struct MealModel : Equatable {
    let id: String
    let name: String
    let category, area, instructions: String
    let thumbnail: String
    let tags: String
    let youtube: String
    let ingredients: [String]
    let source: String
}
