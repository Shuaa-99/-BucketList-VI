//
//  ViewController.swift
//  Bucket List
//
//  Created by administrator on 11/10/2021.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableVCdeleget {
    var items = [BucketListItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()

        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemcell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
return cell
       
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editSegue", sender: indexPath)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
        let navgationController = segue.destination as! UINavigationController
        let addItemTableVController = navgationController.topViewController as! AddItemsTableViewController
            addItemTableVController.deleget = self}
        else if segue.identifier == "editSegue"{
            let navgationController = segue.destination as! UINavigationController
            let addItemTableVController = navgationController.topViewController as! AddItemsTableViewController
            addItemTableVController.deleget = self
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemTableVController.item = item.text!
            addItemTableVController.indexPath = indexPath
        }
    }
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        }catch {
             print(error)
            }
    }
    func cancelButtPress(by controller: AddItemsTableViewController) {
    //    print("I'm here becuse cancel butt pree")
        dismiss(animated: true, completion: nil)
    }
    func itemSaved(by controller: AddItemsTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let iP = indexPath{
          let item =  items[iP.row]
            item.text = text
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        do {
            try managedObjectContext.save()
        }catch{ print(error)}
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
}

