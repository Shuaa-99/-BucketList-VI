//
//  AddItemsTableViewController.swift
//  Bucket List
//
//  Created by administrator on 11/10/2021.
//

import UIKit

class AddItemsTableViewController: UITableViewController {
    weak var deleget: AddItemTableVCdeleget?
    var indexPath: NSIndexPath?
    var item: String?
    @IBOutlet weak var myTextfield: UITextField!
    @IBAction func saveButt(_ sender: UIBarButtonItem) {
        let text = myTextfield.text!
        deleget?.itemSaved(by: self, with: text,  at: indexPath)
    }
    
    @IBAction func cancelButt(_ sender: UIBarButtonItem) {
        deleget?.cancelButtPress(by: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextfield.text = item
        
    }

}
