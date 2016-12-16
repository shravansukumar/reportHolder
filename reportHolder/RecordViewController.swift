//
//  RecordViewController.swift
//  reportHolder
//
//  Created by Shravan Sukumar on 12/12/16.
//  Copyright © 2016 shravan. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
  
  // MARK: - Variables
  var dataArray = [Any]()
  var mutableDictionary = [String: String]()
  var dictionary = [String : [String]]()
  weak var homeViewController : HomeViewController?
  
  // MARK: - IBOutlets
  @IBOutlet weak var nameWrapperView: UIView!
  @IBOutlet weak var ageWrapperView: UIView!
  @IBOutlet weak var genderWrapperView: UIView!
  @IBOutlet weak var addressWrapperView: UIView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var genderTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchRecordsAndSetupViews()
  }
  
  // MARK: - Private Methods
  func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
      updates()
    }
  }
  
  private func fetchRecordsAndSetupViews() {
    let endPointUrl = URL(string: "http://www.mocky.io/v2/5851906f0f0000fa0e046d3f")
    let urlRequest = URLRequest(url: endPointUrl!)
    let session = URLSession.shared
    let task = session.dataTask(with: urlRequest) {
      (data, response, error) in
      do {
         self.dataArray = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]

        for currentIndex in 0 ..< self.dataArray.count {
          self.mutableDictionary =  (self.dataArray[currentIndex] as! [String : String]);
          for (key,value) in self.mutableDictionary {
            
            self.performUIUpdatesOnMain {
              if key == "field-name" && value == "name" {
                self.nameWrapperView.isHidden = false
              } else if key == "field-name" && value == "age" {
                self.ageWrapperView.isHidden = false
              }  else if key == "field-name" && value == "address" {
                self.addressWrapperView.isHidden = false
              }  else if key == "field-name" && value == "gender" {
                self.genderWrapperView.isHidden = false
              }
            }
          }
        }
      } catch  {
        print("error trying to convert JSON dictionary")
        return
      }
    }
    task.resume()
  }
  
  // MARK: - IBActions
  @IBAction func doneButtonPressed(_ sender: Any) {
    
    var nameText: String = nameTextField.text!
    nameText = (nameTextField.text == "") ? " " : nameText
    var ageText: String = ageTextField.text!
    ageText = (ageTextField.text == "") ? " " : ageText
    var genderText: String = genderTextField.text!
    genderText = (nameTextField.text == "") ? " " : genderText
    var addressText: String = addressTextField.text!
    addressText = (addressTextField.text == "") ? " " : addressText
    
    homeViewController?.nameArray.append(nameText)
    homeViewController?.ageArray.append(ageText)
    homeViewController?.addressArray.append(addressText)
    homeViewController?.genderArray.append(genderText)

    dismiss(animated: true, completion: nil)
  }
}
