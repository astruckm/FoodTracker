//
//  RecipeViewController.swift
//  FoodTracker
//
//  Created by ASM on 2/19/18.
//

import UIKit


protocol ModalViewControllerDelegate {
    func sendValue(_ value: String)
}

class RecipeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var recipeText: UITextView!
    
    var recipeDelegate: ModalViewControllerDelegate? //Used to send value of recipe text to MealViewController
    var recipe: String? //Store recipe text received from MealViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            recipeText.text = recipe
        }
        
        recipeText.delegate = self
    }

    
    //MARK: UITextViewDelegate
    private func textViewShouldEndEditing(_ textView: UITextView) {
        recipeText.resignFirstResponder()
    }

    // MARK: Navigation
     @IBAction func done(_ sender: UIButton) {
        recipeText.resignFirstResponder()
        self.recipeDelegate?.sendValue(recipeText.text)
        dismiss(animated: true, completion: nil)
     }



}
