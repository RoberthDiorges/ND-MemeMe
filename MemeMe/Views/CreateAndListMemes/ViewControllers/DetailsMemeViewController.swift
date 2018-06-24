//
//  DetailsMemeViewController.swift
//  MemeMe
//
//  Created by Roberth on 19/06/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class DetailsMemeViewController: UIViewController {
  
  @IBOutlet weak var memeImg: UIImageView!
  
  var meme: Meme?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setMemeImage(meme: meme)
  }
  
  func setMemeImage(meme: Meme?) {
    guard let memeImage = meme?.memeImage else { return }
    memeImg.image = memeImage
  }
}
