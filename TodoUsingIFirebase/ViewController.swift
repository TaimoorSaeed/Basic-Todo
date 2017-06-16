//
//  ViewController.swift
//  TodoUsingIFirebase
//
//  Created by Taimoor Saeed on 15/06/2017.
//  Copyright © 2017 Taimoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    var tasks : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.tasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit Task", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: {
            (UITextField) in
            UITextField.text = self.tasks[indexPath.row]
        })
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            self.tasks[indexPath.row] = alert.textFields![0].text!
            self.tableView.reloadData()
        })
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func AddTaskBtnPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Add Task", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            self.tasks.append(textField.text!)
            self.tableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Enter Task here"
            textField.clearButtonMode = .whileEditing
        }
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
}

