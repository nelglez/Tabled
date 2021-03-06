//
//  ViewController.swift
//  TabledApp
//
//  Created by Nelson Gonzalez on 1/10/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "cell"

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.dataSource = self
        tableView.delegate = self
      // tableView.isEditing = true
    }


    @IBAction func add(_ sender: UIButton) {
        
        guard let text = textField.text, !text.isEmpty else {return}
        
        Model.shared.addItem(text)
        textField.text = nil
        tableView.reloadData()
    }
    
    
    @IBAction func editTable(_ sender: Any) {
        tableView.setEditing(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stopEditingTable(_:)))
    }
    
    @objc
    func stopEditingTable(_ sender: Any) {
        tableView.setEditing(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTable(_:)))
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return Model.shared.items.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let items = Model.shared.items[indexPath.row]
        
        cell.textLabel?.text = items
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Enable "magic" swipe-to-delete
        guard editingStyle == .delete else { return }
        
        // Implement here
        
        
        Model.shared.removeItem(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Implement here
    
        let item = Model.shared.items[sourceIndexPath.row]
        
        Model.shared.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row, stringValue: item)
        
       
    }
    
    
}
