//
//  InitialViewController+TextFieldExtension.swift
//  MemeMe
//
//  Created by Roberth on 07/05/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

extension InitialViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.text = ""
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if self.topTextField.isFirstResponder {
      if (textField.text?.isEmpty)! {
        textField.text = DefautsTexts.top
      }
    } else {
      if (textField.text?.isEmpty)! {
        textField.text = DefautsTexts.bottom
      }
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
}
