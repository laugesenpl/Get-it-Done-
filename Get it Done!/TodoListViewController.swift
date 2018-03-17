//
//  ViewController.swift
//  Get it Done!
//
//  Created by PAUL LAUGESEN on 3/13/18.
//  Copyright © 2018 PAUL LAUGESEN. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {

    let itemArray = ["Got for Run", "Check Mail", "Pick up drycleaning"]
    
 //   @IBOutlet var todoList: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        todoList.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


 
}

