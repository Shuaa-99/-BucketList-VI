//
//  AddItemsVCdeleget.swift
//  Bucket List
//
//  Created by administrator on 12/10/2021.
//

import Foundation

protocol AddItemTableVCdeleget: class {
    func itemSaved(by controller: AddItemsTableViewController, with text: String, at indexPath: NSIndexPath?)
   func cancelButtPress(by controller: AddItemsTableViewController)
}
