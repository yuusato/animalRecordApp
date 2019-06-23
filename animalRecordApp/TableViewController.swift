//
//  TableViewController.swift
//  animalRecordApp
//
//  Created by 佐藤結 on 2019/06/21.
//  Copyright © 2019 佐藤結. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var list: [String] = []
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     UserDefaults.standard.removeObject(forKey:"NewFile" )
        UserDefaults.standard.removeObject(forKey:"list1" )
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "list") != nil {
            list = UserDefaults.standard.object(forKey: "list") as! [String]
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
        }
        UserDefaults.standard.set(list, forKey: "list")
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)

        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
   
    
    @IBAction func addButtom(_ sender: Any) {
        
        let alart = UIAlertController(title: "追加", message: "追加文字を入れて下さい。", preferredStyle: .alert)
        
        alart.addTextField { (text:UITextField!) in
            text.placeholder = "名前を入れて下さい"
            text.tag = 1
            
        }
       
        
        let okAction = UIAlertAction(title: "ok", style: .default) { (action:UIAlertAction) in
            guard let textFields:[UITextField] = alart.textFields else {return}
            
            
            
            
            for textField in textFields {
                if textField.text! != "" {
                    let textf = String(textField.text!)
                    self.list.append(textf)
                    
                    UserDefaults.standard.set(self.list, forKey: "list")
                    self.tableView.reloadData()
                    
                    
                }else{
                    break
                }
            }
        }
        
        alart.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        alart.addAction(cancelAction)
        present(alart, animated: true, completion: nil)
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        UserDefaults.standard.set(selectedRow,forKey: "rowNum")
    }
    
    
    
    
    
    
    

    
}
