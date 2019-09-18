//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Tarik M on 9/17/19.
//  Copyright © 2019 Tarik M. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let realm = try! Realm()
    var categories : Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
    }


    
    
    //MARK: - TableView Data Source Methods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        }
    
    override func prepare(for segue : UIStoryboardSegue , sender : Any?) {
        let destiantionVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destiantionVC.selectedCategory = categories?[indexPath.row]
            
        }
        
    }
    
    
    
    
    //MARK: - Data Manipulation Method

    func save(category : Category){
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error \(error)")
        }
        tableView.reloadData()
        
        
        
    }
    
    
    func loadCategories(){

            categories = realm.objects(Category.self)
        
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//        categories = try context.fetch(request)
//        }catch {
//            print("error loading categories \(error)")
//        }
//        tableView.reloadData()
//        
    
    }
    
    
    
    //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            self.save(category: newCategory)
            
        }
        
        
        
            alert.addAction(action)
        
            alert.addTextField { (field) in
                textField = field
                textField.placeholder = "add neww category"
                
            }
            
            present(alert,animated: true ,completion: nil)
            
        }
    
    
    
    
    
    
    }
    
    


    
    

