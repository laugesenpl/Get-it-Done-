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
        if let items = defaults.object(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
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

//    func getItems() {
//
//        if !(dataFilePath?.isFileURL)! {
//
//            guard let bundlePath = Bundle.main.path(forResource: "GameData", ofType: "plist") else { return }
//
//            do {
//                try fileManager.copyItem(atPath: bundlePath, toPath: path)
//            } catch let error as NSError {
//                print("Unable to copy file. ERROR: \(error.localizedDescription)")
//            }
//        }
//    }
    
//    func loadGameData() {
//        
//        // getting path to GameData.plist
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
//        let documentsDirectory = paths[0] as String
//        let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
//        
//        let fileManager = NSFileManager.defaultManager()
//        
//        //check if file exists
//        if(!fileManager.fileExistsAtPath(path)) {
//            // If it doesn't, copy it from the default file in the Bundle
//            if let bundlePath = NSBundle.mainBundle().pathForResource("GameData", ofType: "plist") {
//                
//                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
//                println("Bundle GameData.plist file is --> \(resultDictionary?.description)")
//                
//                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
//                println("copy")
//            } else {
//                println("GameData.plist not found. Please, make sure it is part of the bundle.")
//            }
//        } else {
//            println("GameData.plist already exits at path.")
//            // use this to delete file from documents directory
//            //fileManager.removeItemAtPath(path, error: nil)
//        }
//        
//        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
//        println("Loaded GameData.plist file is --> \(resultDictionary?.description)")
//        
//        var myDict = NSDictionary(contentsOfFile: path)
//        
//        if let dict = myDict {
//            //loading values
//            bedroomFloorID = dict.objectForKey(BedroomFloorKey)!
//            bedroomWallID = dict.objectForKey(BedroomWallKey)!
//            //...
//        } else {
//            println("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
//        }
//    }

    
    
}

