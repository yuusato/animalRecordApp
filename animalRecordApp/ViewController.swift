//
//  ViewController.swift
//  animalRecordApp
//
//  Created by 佐藤結 on 2019/06/23.
//  Copyright © 2019 佐藤結. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var NewList: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let row:Int = UserDefaults.standard.object(forKey: "rowNum") as! Int
        if UserDefaults.standard.object(forKey: "NewList") != nil {
            NewList = UserDefaults.standard.object(forKey: "NewList") as! [[String : String]]
            dateLabel.text = NewList[row]["date"]
            textView.text = NewList[row]["memo"]
        }
    }
    
    
    
    var memo : [String] = []
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBAction func saveButtun(_ sender: Any) {
        let row:Int = UserDefaults.standard.object(forKey: "rowNum") as! Int
        
        NewList[row]["memo"] = textView.text as! String
        UserDefaults.standard.set(NewList, forKey: "NewList")
    
    }
    
    
    
    
    
    
    

}
