//
//  ListMemesTableViewController.swift
//  MemeMe
//
//  Created by Roberth on 18/06/2018.
//  Copyright © 2018 Roberth. All rights reserved.
//

import UIKit

class ListMemesTableViewController: UITableViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var addBtn: UIBarButtonItem!
  
  // MARK: - Variables
  private var memes = (UIApplication.shared.delegate as! AppDelegate).memes
  private let listMemesIdentifierTableCell = "listMemesIdentifierTableCell"
  
  struct IdentifierSegues {
    static let kTableViewNewMemeSegue = "tableViewNewMemeIdentifierSegue"
    static let kTableViewDetailsSegue = "tableViewShowDetailIdentifierSegue"
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    memes = (UIApplication.shared.delegate as! AppDelegate).memes
    tableView.reloadData()
  }
  
  // MARK: - Methods
  func configTableView() {
    tableView.tableFooterView = UIView()
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: listMemesIdentifierTableCell, for: indexPath) as? ListMemesTableViewCell else {
      return UITableViewCell()
    }
    cell.setup(meme: memes[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: IdentifierSegues.kTableViewDetailsSegue, sender: memes[indexPath.row])
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == IdentifierSegues.kTableViewDetailsSegue {
      let vc = segue.destination as! DetailsMemeViewController
      vc.meme = sender as? Meme
    }
  }
}
