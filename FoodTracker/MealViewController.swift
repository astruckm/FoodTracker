//
//  MealViewController.swift
//  FoodTracker
//
//  Created by ASM on 7/28/17.
//  Copyright © 2017 ASM. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ModalViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var recipeTextView: UITextView!
    
    //This value is either passed by MealTableViewController in prepare(for:sender:) or constructed as part of adding a new meal.
    var meal: Meal?
    
    //Track whether user has not yet edited the recipe text
    var userHasNotEditedRecipe = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        recipeTextView.delegate = self
        
        //Set up views if editing an existing meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            recipeTextView.text = meal.recipe
        }
        
        //Set up recipe's placeholder text or load saved text
        if recipeTextView.text.isEmpty {
            recipeTextView.text = "recipe or notes"
            recipeTextView.textColor = UIColor.lightGray
        } else {
            recipeTextView.textColor = UIColor.black
            recipeTextView.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.light)
            userHasNotEditedRecipe = false
        }
        
        // Enable the save button only if the text field has a valid Meal name.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    //MARK: UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        performSegue(withIdentifier: "Recipe", sender: self)
        return false
    }
    
    //MARK: ModalViewControllerDelegate
    func sendValue(_ value: String) {
        recipeTextView.text = value
        recipeTextView.textColor = UIColor.black
    }
    
    
    //MARK: UIImagePickerControlDelegate functions
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dimiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //Depending on the style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
        
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "Recipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.recipe = userHasNotEditedRecipe ? "" : recipeTextView.text
            recipeViewController.recipeDelegate = self
        }
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button == saveButton else { os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let recipe = recipeTextView.text
        
        meal = Meal(name: name, photo: photo, rating: rating, recipe: recipe)
    }
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard.
        nameTextField.resignFirstResponder()
        recipeTextView.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure the ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func tapCamera(_ sender: UIButton) {
        //Hide the keyboard.
        nameTextField.resignFirstResponder()
        recipeTextView.resignFirstResponder()

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //UIImagePickerController is a view controller that lets a user take a photo.
            let imagePickerController = UIImagePickerController()
            
            //Enable photos to be taken.
            imagePickerController.sourceType = .camera
            
            //Make sure the ViewController is notified when the user takes a photo.
            imagePickerController.delegate = self
            imagePickerController.allowsEditing = false
            self.present(imagePickerController, animated: true, completion: nil)
        } else {  os_log("Camera source type not available", log: OSLog.default, type: .debug)
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        //Disable the Save Button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
}

