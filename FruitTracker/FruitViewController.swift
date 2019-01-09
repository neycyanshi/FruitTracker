//
//  FruitViewController.swift
//  FruitTracker
//
//  Created by yanshi on 2018/12/13.
//  Copyright © 2018 BodyFusion Inc. All rights reserved.
//

import os.log
import UIKit

class FruitViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: Properties
  
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var ratingControl: RatingControl!
  @IBOutlet var saveButton: UIBarButtonItem!
  /*
   This value is either passed by `FruitTableViewController` in `prepare(for:sender:)` or constructed as part of adding a new fruit.
   */
  var fruit: Fruit?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Handle the text field's user input through delegate callbacks
    nameTextField.delegate = self
    
    // Enable the Save button only if the text field has a valid Fruit name.
    updateSaveButtonState()
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide the keyboard
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save button while editing
    saveButton.isEnabled = false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  // MARK: UIImagePickerControllerDelegate
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    // The info dictionary may contain multiple representations of the image. You want to use the original. unwrap the optional using guard and cast to UIImage
    guard let selectedImage = info[.originalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    }
    
    // Set photoImageView to display the selected image.
    photoImageView.image = selectedImage
    
    // Dismiss the picker
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Navigation
  
  // This method lets you configure a view controller before it's presented
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    // Configure the destination view controller only when the save button is pressed, use identity operator(===) to check.
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    let name = nameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    
    // Set the fruit to be passed to FruitTableViewController after the unwind segue.
    fruit = Fruit(name: name, photo: photo, rating: rating)
  }
  
  // MARK: Actions
  
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    // Hide the keyboard
    nameTextField.resignFirstResponder()
    
    // UIImagePickerController is a view controller that lets user pick media from their photo library
    let imagePickerController = UIImagePickerController()
    // Only allow photos to be picked, not taken
    imagePickerController.sourceType = .photoLibrary
    // Make sure ViewController is notified when the user picks an image
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil) // TODO: try to set animated to false
  }
  
  // MARK: Private Methods
  
  private func updateSaveButtonState() {
    // Disable the Save button if the text field is empty.
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}
