//
//  ViewController.swift
//  Todoey
//
//  Created by Tarik M on 9/2/19.
//  Copyright © 2019 Tarik M. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift



class ToDoListViewController: UITableViewController  {
    
	var toDoItems: Results<Item>?
	let realm = try! Realm()
	var selectedCategory : Category? {
		didSet {
			loadItems()
		}
	}
	
	
	
//	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let defaults = UserDefaults.standard
	
//	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//
	
	
    override func viewDidLoad() {
		
//		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
		
        // Do any additional setup after loading the view.
		
//		print(dataFilePath)
//
//        let newItem = Item()
//        newItem.title = "One"
//        toDoItems.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Two"
//        toDoItems.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Three"
//        toDoItems.append(newItem3)
//
		
		
//			loadItems()
		
		
		
		
		
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            toDoItems = items
//        }
    }

	//MARK: - Tableview Datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		if let item = toDoItems?[indexPath.row] {
			cell.textLabel?.text =  item.title
			cell.accessoryType = item.done ? .checkmark : .none
		}else {
			cell.textLabel?.text = "No items added"
		}

        return cell
    }
	
	//MARK: - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		
		if let item = toDoItems?[indexPath.row]{
			do{
				try realm.write {
					item.done = !item.done
			}
			}catch{
				print("error \(error)")
			}
			
			}
		tableView.reloadData()
       tableView.deselectRow(at: indexPath, animated: true)
		
    }
    
	//MARK: - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        let alert = UIAlertController(title : "add new Todeoy item" , message :"" , preferredStyle : .alert)
        
        let action = UIAlertAction(title : "Add item" , style : .default) { (action) in
                
            //what will happen when user clicks the add item button
			
			
			if let currentCategoty = self.selectedCategory {
				do{
					try self.realm.write {
						let newItem = Item()
						newItem.title = textField.text!
						newItem.dateCreated = Date()
						currentCategoty.items.append(newItem)
					}
				}catch {
					print("error \(error)")
				}
				
			}
			self.tableView.reloadData()
		}
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
           
        }
            alert.addAction(action)
            self.present(alert , animated : true , completion : nil)
        
    }
	
	//MARK: - Model Manipulation Method
	
	
	func loadItems(){
		toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
		tableView.reloadData()
	}

}
	


//MARK: - Search bar methods
extension ToDoListViewController : UISearchBarDelegate{


	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		

		
		toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
		tableView.reloadData()	
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text!.count == 0 {
			loadItems()
			DispatchQueue.main.async {
				searchBar.resignFirstResponder()
			}
		}
	}
}


 
