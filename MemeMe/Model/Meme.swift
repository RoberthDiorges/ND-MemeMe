//
//  Meme.swift
//  MemeMe
//
//  Created by Roberth on 07/05/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

struct Meme {
  let topText: String?
  let originalImage: UIImage?
  let memeImage: UIImage?
  let bottomText: String?
  
  init(topText: String?, originalImage: UIImage?, memeImage: UIImage?, bottomText: String?) {
    self.topText = topText
    self.bottomText = bottomText
    self.originalImage = originalImage
    self.memeImage = memeImage
  }
}
