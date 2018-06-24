//
//  CreateMemeViewController.swift
//  MemeMe
//
//  Created by Roberth on 26/04/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: Properties
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var actionButton: UIBarButtonItem!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var navigationBar: UINavigationBar!
  
  // MARK: Variables
  enum ButtonType: Int {
    case camera = 0, photoLibrary
  }
  
  struct DefautsTexts {
    static let top = "TOP"
    static let bottom = "BOTTOM"
  }
  
  var textFields = [UITextField]()
  
  // MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configKeyboard()
    configTextFields(textFields: [topTextField, bottomTextField])
    configCamera()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    actionButton.isEnabled = imageView.image != nil
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    unsubscribeFromKeyboardNotifications()
  }
  
  // MARK: Picker Controlls
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.contentMode = .scaleAspectFit
      imageView.image = image
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func pickAnImage(dataType: UIImagePickerControllerSourceType) {
    
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = dataType
    imagePicker.delegate = self
    present(imagePicker, animated: true, completion: nil)
  }
  
  // MARK: - Auxiliary methods
  func cutMeme(x: CGFloat, y: CGFloat) {
    self.view.drawHierarchy(in: CGRect(x: x, y: y,
                                       width: view.bounds.size.width,
                                       height: view.bounds.size.height),
                            afterScreenUpdates: true)
  }
  
  func save(memedImage: UIImage) {
    
    let meme = Meme(topText: topTextField.text, originalImage: imageView.image, memeImage: memedImage, bottomText: bottomTextField.text)
    
    (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    dismiss(animated: true, completion: nil)
  }
  
  func generateMemedImage() -> UIImage {
    
    // Render view to an image
    navigationBar.isHidden = true
    toolbar.isHidden = true
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: imageView.frame.size.width,
                                                  height: imageView.frame.size.height), false, 0)
    
    switch UIApplication.shared.statusBarOrientation {
    case .portrait, .portraitUpsideDown:
      cutMeme(x: 0, y: -75)
      break
    case .landscapeLeft, .landscapeRight:
      cutMeme(x: 0, y: -45)
      break
    case .unknown:
      print("Erro")
      break
    }

    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    navigationBar.isHidden = false
    toolbar.isHidden = false
    
    return memedImage
  }
  
  // MARK: Keybboard controlls
  func configKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillShow(_ notification:Notification) {
    if self.bottomTextField.isFirstResponder {
      
      let userInfo = notification.userInfo
      let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
      
      let heightKeyboard =  keyboardSize.cgRectValue.height
      
      self.view.frame.origin.y = heightKeyboard * (-1)
    }
  }
  
  @objc func keyboardWillHide(notification: Notification) {
    self.view.frame.origin.y = 0
  }
  
  // MARK: UIConfiguration
  func configCamera() {
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
  }
  
  func configTextFields(textFields: [UITextField]) {
    
    let multipleAttributes: [String : Any] = [
      NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
      NSAttributedStringKey.strokeWidth.rawValue: -4,
      NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
      NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) as Any
    ]
    
    for t in textFields {
      t.delegate = self
      t.defaultTextAttributes = multipleAttributes
      t.textAlignment = .center
    }
  }
  
  // MARK: IBActions
  @IBAction func getPhotoButtonPressed(_ sender: UIBarButtonItem) {
    switch (ButtonType(rawValue: sender.tag)!) {
    case .camera:
      pickAnImage(dataType: .camera)
    case .photoLibrary:
      pickAnImage(dataType: .photoLibrary)
    }
  }
  
  @IBAction func buttonCancelPressed(_ sender: UIBarButtonItem) {
    imageView.image = nil
    actionButton.isEnabled = false
    topTextField.text = DefautsTexts.top
    bottomTextField.text = DefautsTexts.bottom
    imageView.reloadInputViews()
  }
  
  @IBAction func buttonSharedPressed(_ sender: Any) {
    let memedImage = generateMemedImage()
    let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    self.present(activityViewController, animated: true, completion: nil)
    activityViewController.completionWithItemsHandler = {(activity, completed, items, error) in
      if (completed) {
        self.save(memedImage: memedImage)
      }
    }
  }
}
