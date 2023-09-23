//
//  MealsResponseModel.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation

struct MealsResponseModel: Decodable {
    let meals: [MealResponseModel]?
}

struct MealResponseModel : Decodable {
    let idMeal: String
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    func toDomain() -> MealModel {
        var ingredients = [String]()
        let strIngredients = [strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20]
        let strMeasures = [strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20]
        for i in 0..<strIngredients.count {
            if let ingredient = strIngredients[i],
               !ingredient.isEmpty {
                let value = "\(ingredient)"
                if let measure = strMeasures[i],
                   !measure.isEmpty {
                    ingredients.append("\(value) - \(measure)")
                } else {
                    ingredients.append("\(ingredient)")
                }
            }
        }
        
        return MealModel(id: idMeal, name: strMeal ?? "", category: strCategory ?? "", area: strArea ?? "", instructions: strInstructions ?? "", thumbnail: strMealThumb ?? "", tags: strTags ?? "", youtube: strYoutube ?? "", ingredients: ingredients, source: strSource ?? "")
    }
}
