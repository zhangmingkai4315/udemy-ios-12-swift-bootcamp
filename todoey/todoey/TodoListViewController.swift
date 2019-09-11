//
//  ViewController.swift
//  todoey
//
//  Created by 明凯张 on 2019/9/11.
//  Copyright © 2019 明凯张. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray :[Todo] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemArray.append(Todo(name: "test", checked: false))
        if let items = defaults.array(forKey: "TodoListArray") as? [Todo]{
            self.itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 但是需要注意复用的时候，如果处理不当会导致cell状态也被复用
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell",for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row ].name
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Table view delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].checked = !itemArray[indexPath.row].checked
        let item = tableView.cellForRow(at: indexPath)
    
        
        if item?.accessoryType == .checkmark{
            item?.accessoryType = .none
        }else{
            item?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addTodoBtnPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default){ action in
            
            self.itemArray.append(Todo(name:textField.text! , checked: false))
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "todo..."
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



