//
//  GetAge.swift
//  animalRecordApp
//
//  Created by 佐藤結 on 2019/06/22.
//  Copyright © 2019 佐藤結. All rights reserved.
//
import Foundation

class GetAge {
    //誕生日から年齢を生成するけ関数
    static func age(byBirthDate birthDate: Date) -> Int {
        
        //タイムゾーンを東京に設定して、東京での現在の日時を取得
        let timezone: TimeZone = TimeZone(identifier: "Asia/Tokyo")!
        let localDate = Date(timeIntervalSinceNow: Double(timezone.secondsFromGMT()))
        
        
        //計算できるようにInt型に変換
        let localDateIntVal = Int(string(localDate, format: "yyyyMMdd"))
        let birthDateIntVal = Int(string(birthDate, format: "yyyyMMdd"))
        
        print(localDateIntVal!)
        print(birthDateIntVal!)
        
        //年齢の計算（現在の年月日-誕生日の年月日）
        let age = (localDateIntVal! - birthDateIntVal!) / 10000
//        print(age)
        
        //年齢が値として返ってくる
        return age
    }
    
    static func string(_ date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
    
}
