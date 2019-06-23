//
//  AnimalData.swift
//  animalRecordApp
//
//  Created by 佐藤結 on 2019/06/21.
//  Copyright © 2019 佐藤結. All rights reserved.
//

import UIKit

import AssetsLibrary
import Photos



class AnimalData: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource {
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
    
    //歳が表示されれるところ
    @IBOutlet weak var Age: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // Do any additional setup after loading the view.
    
    
    //日付を設定するところ
    @IBOutlet weak var dateField: UITextField!
    

    //性別をかえる画像
    @IBOutlet weak var imageView: UIImageView!
    //画像を変えるためのボタン
    @IBAction func tapped(_ sender: Any) {
        if num < 4 {
            imageView.image = UIImage(named: "\(num)")
            num += 1
        } else {
            imageView.image = UIImage(named: "4")
            num = 1
        }
    }
    
    
    @IBOutlet weak var photoView: UIImageView!
    //フォトライブラリーにアクセス
    @IBAction func tapPhotoLibraryButton(_ sender: UIButton) {
        openPicker(type: .photoLibrary)
    }
    

    
    
    // アラートを出す関数
    //使うときはshowAlert(message: "表示したいメッセージ")とかけばいい
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    func openPicker(type: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        //let imageUrl = info[.imageURL] as? URL
        //        imageUrlStr = String(describing: imageUrl!)
        //
        //        print("imageUrl:\n\(String(describing: imageUrl!))")
        
        photoView.image = image
        saveImage(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //iPhoneのデフォルトの写真一覧
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            // 新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func saveImage (_ image: UIImage){
        //pngで保存する場合
        let pngImageData = image.pngData()
        // jpgで保存する場合
        //    let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        let currentTime:String = "\(NSDate())"
        //とりあえず保存(リストにするときは変更必要)
       // day.updateValue(currentTime, forKey: "time")
        UserDefaults.standard.set(currentTime, forKey: "time")
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        
        
        let fileURL = documentsURL.appendingPathComponent("\(currentTime).png")
        
        
        do {
            try pngImageData!.write(to: fileURL)
            //            let url:String = fileURL.absoluteString
            //            data.updateValue(url, forKey: "signPath")
        } catch {
            return
        }
    }
    

    
    
    
    @IBOutlet weak var tableView: UITableView!
    var list: [String] = []
    
    
    var i: Int = 0
    //選択されたセルの列のばんごうを入れるための変数
    var rowNum: Int = 0
    //この画面になったときに読まれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "list1") != nil {
            list = UserDefaults.standard.object(forKey: "list1") as! [String]
        }
        
        
        
        //選択されたセルを判断
        if UserDefaults.standard.object(forKey: "rowNum") != nil {
            rowNum = UserDefaults.standard.object(forKey: "rowNum") as! Int
        }
        
        if UserDefaults.standard.object(forKey: "NewList") != nil {
            NewList = UserDefaults.standard.object(forKey: "NewList") as! [[String : String]]
        }
        
    }
    
    
    var NewList: [[String: String]] = []
    
    @IBAction func addButton(_ sender: Any) {
        //アラートの設定
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
                    
                    //新しい配列にで日付とメモをいれれるようにした
                    self.NewList.append(["date": textf, "memo": "[ここに文字を入力して下さい]"])
                    UserDefaults.standard.set(self.NewList, forKey: "NewList")
                    UserDefaults.standard.set(self.list, forKey: "list1")
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
    
    
    
    
    
    
    
    
    //セルの設定
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            tableView.reloadData()
            
        }
        UserDefaults.standard.set(list, forKey: "list1")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row + 1). " + list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let selectRow = indexPath.row
        UserDefaults.standard.set(selectRow, forKey: "rowNum")
        
    }

    
    
    
}

        
        

        


    
    

