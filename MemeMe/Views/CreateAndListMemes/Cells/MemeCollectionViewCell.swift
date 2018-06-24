//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Roberth on 18/06/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var memeImg: UIImageView!
  
  func setup(meme: Meme) {
    memeImg.image = meme.memeImage
  }
}
