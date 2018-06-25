//
//  ListMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Roberth on 18/06/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class ListMemesCollectionViewController: UICollectionViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var addBtn: UIBarButtonItem!
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: - Variables
  private let listMemesIdentifierCollectionCell = "memeCell"
  private var memes = (UIApplication.shared.delegate as! AppDelegate).memes
  
  // MARK: - Structs
  struct ViewControllers {
    static let detailsMemeViewControllerIdentifier = "DetailsMemeViewController"
    static let createMemeViewControllerIdentifier = "CreateMemeViewController"
  }
  
  struct IdentifierSegues {
    static let kCollectionNewMemeSegue = "collectionNewMemeIdentifierSegue"
    static let kCollectionDetailsSegue = "collectionShowDetailIdentifierSegue"
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configCollection()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    memes = (UIApplication.shared.delegate as! AppDelegate).memes
    collectionView?.reloadData()
  }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listMemesIdentifierCollectionCell, for: indexPath) as? MemeCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.setup(meme: memes[indexPath.row])
    return cell
  }
  
  // MARK: Methods
  
  private func configCollection() {
    let space:CGFloat = 3.0
    let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
    
    flowLayout.minimumInteritemSpacing = space
    flowLayout.minimumLineSpacing = space
    flowLayout.itemSize = CGSize(width: dimension, height: dimension)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == IdentifierSegues.kCollectionDetailsSegue {
      let vc = segue.destination as! DetailsMemeViewController
      vc.meme = sender as? Meme
    }
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: IdentifierSegues.kCollectionDetailsSegue, sender: self.memes[indexPath.row])
  }
  
  @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: IdentifierSegues.kCollectionNewMemeSegue, sender: nil)
  }
}
