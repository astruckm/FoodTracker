//
//  RecipeViewController.swift
//  FoodTracker
//
//  Created by ASM on 1/13/18.
//  Copyright © 2018 ASM. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate {
    func sendValue(_ value: String)
}

class RecipeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var recipeText: UITextView!
    
    var delegate: ModalViewControllerDelegate?
    var recipe: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            recipeText.text = recipe
        }
        
        recipeText.delegate = self
    }

    
    //MARK: UITextViewDelegate
    //Probably not necessary
    private func textViewShouldEndEditing(_ textView: UITextView) {
        recipeText.resignFirstResponder()
    }
    

    // MARK: - Navigation
     @IBAction func done(_ sender: UIButton) {
        recipeText.resignFirstResponder()
        self.delegate?.sendValue(recipeText.text)
        dismiss(animated: true, completion: nil)
     }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
