//
//  ViewController.swift
//  TodoListApp
//
//  Created by Miguel Segovia Gil on 18/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    var item: Item?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func setLabelText(_ sender: UIButton) {
        nameLabel.text = nameTextField.text
        
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
       let isInAddMode = presentingViewController is UINavigationController
        
       if isInAddMode {
         dismiss(animated: true, completion: nil)
       }
       else {
         navigationController!.popViewController(animated: true)
       }
    }
    
    
    override func viewDidLoad() {
      super.viewDidLoad()

      if let item = item {
         nameTextField.text = item.name
      }

    }
    
    
    /* This method determines whether the Save button has been tapped and then creates the appropriate item object. */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as AnyObject? === saveButton {
            let name = nameTextField.text ?? ""
            item = Item(name: name)
        }
    }


}

