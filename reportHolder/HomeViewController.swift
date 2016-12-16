//
//  HomeViewController.swift
//  reportHolder
//
//  Created by Shravan Sukumar on 12/12/16.
//  Copyright © 2016 shravan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK: - Constants
  static let homeViewToRecordViewSegue = "HomeViewToRecordViewSegueIdentifier"
  
  // MARK: - Variables
  var nameArray = [String]()
  var addressArray = [String]()
  var genderArray = [String]()
  var ageArray = [String]()
  var dictionary = [String : [String]]()
  
  
  // MARK: - IBOutlets
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var totalReportsView: UIView!
  @IBOutlet weak var recordsCountLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTotalReportsView()
    // setupTableView()
    // tableView.reloadData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    tableView.reloadData()
    setupTableView()
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == HomeViewController.homeViewToRecordViewSegue {
      let recordViewController = segue.destination as! RecordViewController
      recordViewController.homeViewController = self
    }
  }
  
  // MARK: - Private Methods
  private func setupTableView() {
    if (nameArray.count > 0) == true {
      tableView.isHidden = false
    }
    
    let nibName = UINib(nibName: "RecordDetailsTableViewCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "RecordDetailsTableViewCell")
  }
  private func setupTotalReportsView() {
    totalReportsView.layer.borderWidth = 0.5
    totalReportsView.layer.borderColor = UIColor.black.cgColor
  }
  
  // MARK: - IBActions
  @IBAction func addButtonTapped(_ sender: Any) {
    performSegue(withIdentifier: HomeViewController.homeViewToRecordViewSegue, sender: nil)
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nameArray.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RecordDetailsTableViewCell") as! RecordDetailsTableViewCell
    cell.ageLabel.text = ageArray[indexPath.row]
    if cell.ageLabel.text == " " {
      cell.ageLabel.isHidden = true
    }
    cell.nameLabel.text = nameArray[indexPath.row]
    if cell.nameLabel.text == " " {
      cell.nameLabel.isHidden = true
      
    }
    return cell
  }
}

