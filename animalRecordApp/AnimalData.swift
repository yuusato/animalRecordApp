//
//  AnimalData.swift
//  animalRecordApp
//
//  Created by 佐藤結 on 2019/06/21.
//  Copyright © 2019 佐藤結. All rights reserved.
//

import UIKit

class AnimalData: UIViewController {
    //UIDatePickerを定義するための変数
    var datePicker: UIDatePicker = UIDatePicker()
    var num: Int = 1
    var birthDay:Date!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
    }
    
    // UIDatePickerのDoneを押したら発火
    @objc func done() {
        dateField.endEditing(true)
        
        // 日付のフォーマット
        let formatter = DateFormatter()
        
        //"yyyy年MM月dd日"を"yyyy/MM/dd"したりして出力の仕方を好きに変更できるよ
        formatter.dateFormat = "yyyy年MM月dd日"
        
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        dateField.text = "\(formatter.string(from: datePicker.date))"
        
        //誕生日の年月日を変数に入れて
        birthDay = datePicker.date
        let age = String(GetAge.age(byBirthDate: birthDay))
        print(age)
        
        Age.text = "\(age)歳"
        
    }
    

    @IBOutlet weak var Age: UILabel!
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // Do any additional setup after loading the view.
    
    

    @IBOutlet weak var dateField: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBOutlet weak var imageView: UIImageView!

    
    
    @IBAction func tapped(_ sender: Any) {
        
    }
        
        
        
        
}
        
        
        

    
    

