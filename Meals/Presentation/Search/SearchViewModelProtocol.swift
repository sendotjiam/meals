//
//  SearchViewModelProtocol.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchViewModelProtocol {
    var dataSubject: PublishSubject<Void> { get }
    
    var displayData: [MealModel] { get }
    
    func onSearch(keyword: String)
}
