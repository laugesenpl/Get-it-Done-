//
//  ViewController.swift
//  Get it Done!
//
//  Created by PAUL LAUGESEN on 3/13/18.
//  Copyright © 2018 PAUL LAUGESEN. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

//    var itemArray = ["Got for Run", "Check Mail", "Pick up drycleaning"]
    
    var firstItem = Item()
    var itemArray = [Item()]
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        firstItem.text = "Do Laundry"
        firstItem.isChecked = false
        itemArray.append(firstItem)
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].text
        
        if itemArray[indexPath.row].isChecked {
            cell.accessoryType = .checkmark
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none

        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        itemArray[indexPath.row].isChecked = !itemArray[indexPath.row].isChecked
        
        saveItems()

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Item
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New To Do Item & Get it Done!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            let newItem = Item()

            if textField.text != nil {
                newItem.text = textField.text!
                newItem.isChecked = false
                self.itemArray.append(newItem)
                
                self.saveItems()
                
//                self.defaults.set(self.itemArray, forKey: "TodoListArray")
                
                
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        

    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }

    func loadItems() {
        let decoder = PropertyListDecoder()

        if let data = try? Data(contentsOf: dataFilePath!) {
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}

