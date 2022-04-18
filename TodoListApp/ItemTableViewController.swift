//
//  ItemTableViewController.swift
//  TodoListApp
//
//  Created by Miguel Segovia Gil on 18/4/22.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var items = [Item]()
    
    static let archiveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("items")

       func saveItems() {
           do {
               let data = try JSONEncoder().encode(items)
               try data.write(to: ItemTableViewController.archiveURL)
           } catch {
               print(error.localizedDescription)
           }
       }

       func loadItems() -> [Item]? {
           do {
               let data = try Data(contentsOf: ItemTableViewController.archiveURL)
               return try JSONDecoder().decode([Item].self, from: data)
           } catch {
               print(error.localizedDescription)
           }
           return nil
       }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
            
          // Load saved items
          if let savedItems = loadItems() {
            items += savedItems
          }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        
        let item = items[indexPath.row]
        cell.nameLabel.text = item.name

        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
     let srcViewCon = sender.source as? ViewController
     let item = srcViewCon?.item
     if (srcViewCon != nil && item?.name != "") {
       if let selectedIndexPath = tableView.indexPathForSelectedRow {
           // Update an existing task.
         items[selectedIndexPath.row] = item!
         tableView.reloadRows(at: [selectedIndexPath], with: .none)
       }
       else {
         // Add a new meal.
         let newIndexPath = NSIndexPath(row: items.count, section: 0)
         items.append(item!)
         tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
           
       }
         saveItems()
     }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          items.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
      }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "ShowDetail" {
        let detailVC = segue.destination as! ViewController
            
        // Get the cell that generated this segue.
        if let selectedCell = sender as? ItemTableViewCell {
          let indexPath = tableView.indexPath(for: selectedCell)!
          let selectedItem = items[indexPath.row]
          detailVC.item = selectedItem
         }
       }
      else if segue.identifier == "AddItem" {
        
       }
    }
    

}
