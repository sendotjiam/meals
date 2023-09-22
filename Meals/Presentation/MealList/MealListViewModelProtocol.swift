//
//  MealListViewModelProtocol.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation
import RxSwift
import RxRelay

protocol MealListViewModelProtocol {
    var loadingSubject: BehaviorRelay<Bool> { get }
    var dataSubject: PublishSubject<Void> { get }
    
    var displayData: [MealModel] { get }
    
    func onLoad(with letter: String)
}

