//
//  CategoryViewController.swift
//  Get it Done!
//
//  Created by PAUL LAUGESEN on 3/28/18.
//  Copyright © 2018 PAUL LAUGESEN. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    var selectedIndexPathRow : Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newCategory = Category(context: context)
        
//        newCategory.name = "Saturday Morning Chores"
//        categories.append(newCategory)
        loadCategories()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
        
    }

    //MARK: - TableView Delegate Methods

    
    //MARK: - Data Manipulation Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        selectedIndexPathRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! TodoViewController
            
//            print("here \(tableView.indexPathForSelectedRow)")
            print("selectedIndexPathRow \(selectedIndexPathRow)")
            if let row = selectedIndexPathRow {
                destinationVC.selectedCategory = categories[row]
                print("selected category: \(categories[row])")
            }
        }
    
    }



    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category & Get it Done!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
            let newCategory = Category(context: self.context)

            
            if textField.text != nil {
                newCategory.name = textField.text!
                self.categories.append(newCategory)
                self.saveCategories()

            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a New Category"
            textField = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        

    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }

    
}
