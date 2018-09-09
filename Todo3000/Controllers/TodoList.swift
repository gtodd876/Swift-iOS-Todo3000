//
//  ViewController.swift
//  Todo3000
//
//  Created by Todd Matthews on 8/12/18.
//  Copyright © 2018 Todd Matthews. All rights reserved.
//

import UIKit

class TodoList: UITableViewController {

    var itemArray = [Item]()
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    //MARK - TAbleview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
       cell.accessoryType = item.checked ? .checkmark : .none

        return cell
    }
    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK = Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add New Todo", message: "", preferredStyle: .alert)
        let action = UIAlertAction (title: "Add Item", style: .default) {(action) in
            let newItem = Item()
            newItem.title = alertTextField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        alert.addTextField { (alertText) in
            alertText.placeholder = "Create new item"
            alertTextField = alertText
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("error encoding array, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error decoding items in array, \(error)")
            }
            
        }
    }
}
