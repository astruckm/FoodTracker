//
//  Meal.swift
//  FoodTracker
//
//  Created by ASM on 8/8/17.
//  Copyright © 2017 ASM. All rights reserved.
//

import UIKit

class dummy: UITableViewCell {
    
    //MARK: Properties
    var meals = [Meal]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //Private Methods
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else { fatalError("Unable to instantiate meal1") }
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else { fatalError("Unable to instantiate meal2") }
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3") }
        
        meals += [meal1, meal2, meal3]
        
    }
}
