//
//  SRPViewController.swift
//  testView
//
//  Created by Рамил Гаджиев on 28.02.2022.
//

import UIKit

class SRPViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let caloriesCalculator = CaloriesCalculator(type: .harrisBenedict)
        let calories = caloriesCalculator.caloriesCalculate()
        let nutrientsCalculator = NutrientCalculator(type: .keto, calories: calories)
        let nutrients = nutrientsCalculator.calculateDailtyNutrients()
    }
}

protocol CaloriesCalculatable {
    var caloriesType: CaloriesCalculationType { get }
    init(type: CaloriesCalculationType)
    func caloriesCalculate() -> Int
}

protocol NutrientCalculatable {
    var calories: Int { get }
    var proportionType: ProportionType { get }
    init(type: ProportionType, calories: Int)
    func calculateDailtyNutrients() -> Nutrients
}

struct Nutrients {
    var carbs: Int
    var fats: Int
    var proteins: Int
}

enum CaloriesCalculationType {
    case mifflin
    case harrisBenedict
}

enum ProportionType {
    case paleo
    case keto
}

struct CaloriesCalculator: CaloriesCalculatable {
    var caloriesType: CaloriesCalculationType
    
    init(type: CaloriesCalculationType) {
        self.caloriesType = type
    }
    func caloriesCalculate() -> Int {
        switch self.caloriesType {
        case .mifflin:
            return 40
        case .harrisBenedict:
            return 50
        }
    }
}

struct NutrientCalculator: NutrientCalculatable {
    var calories: Int
    var proportionType: ProportionType
    
    init(type: ProportionType, calories: Int) {
        self.proportionType = type
        self.calories = calories
    }
    
    func calculateDailtyNutrients() -> Nutrients {
        switch self.proportionType {
        case .paleo:
            return  Nutrients(
                carbs: self.calories/2,
                fats: self.calories,
                proteins: self.calories*2
            )
        case .keto:
            return  Nutrients(
                carbs: self.calories/4,
                fats: self.calories + 2,
                proteins: self.calories*3
            )
        }
    }
}
