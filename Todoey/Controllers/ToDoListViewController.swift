//
//  ViewController.swift
//  Todoey
//
//  Created by Tarik M on 9/2/19.
//  Copyright © 2019 Tarik M. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
//    let defaults = UserDefaults.standard
	
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
//		print(dataFilePath)
//
//        let newItem = Item()
//        newItem.title = "One"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Two"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Three"
//        itemArray.append(newItem3)
//
		loadItems()
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//        }
    }

    //MARK - Tableview Datasource method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text =  item.title
		
		
		cell.accessoryType = item.done ? .checkmark : .none
		
		
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    
    //MARK - TableView delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       print(itemArray[indexPath.row])
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
	   saveItems()
       tableView.deselectRow(at: indexPath, animated: true)
		
    }
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField  = UITextField()
        let alert = UIAlertController(title : "add new Todeoy item" , message :"" , preferredStyle : .alert)
        
        let action = UIAlertAction(title : "Add item" , style : .default) { (action) in
                
            //what will happen when user clicks the add item button

            let newItem = Item()
            newItem.title = textField.text!
           
            self.itemArray.append(newItem)

//			self.defaults.set(self.itemArray, forKey: "ToDoListArray")
			self.saveItems()
		}
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
           
        }
            alert.addAction(action)
            self.present(alert , animated : true , completion : nil)
        
    }
	
	//Mark - Model Manipulation Method
	func saveItems(){
		
		let encoder = PropertyListEncoder()
		do{
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		}
		catch{
			print("error")
		}
		
		tableView.reloadData()
		
	}
	
	func loadItems(){
		if let data = try? Data(contentsOf: dataFilePath!) {
			let decoder = PropertyListDecoder()
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch{
				print("erorrrrrr")
			}
		}
		
	}
}



