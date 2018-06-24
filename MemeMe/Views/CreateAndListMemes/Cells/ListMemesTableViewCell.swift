//
//  ListMemesTableViewCell.swift
//  MemeMe
//
//  Created by Roberth on 18/06/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class ListMemesTableViewCell: UITableViewCell {
  
  @IBOutlet weak var memeImg: UIImageView!
  @IBOutlet weak var topLbl: UILabel!
  @IBOutlet weak var BottomLbl: UILabel!
  
  func setup(meme: Meme) {
    memeImg.image = meme.memeImage
    topLbl.text = meme.topText
    BottomLbl.text = meme.bottomText
  }
}
