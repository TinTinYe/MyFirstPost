//
//  TeaData.swift
//  MyFirstPost
//
//  Created by Yvonne on 2019/12/23.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import Foundation


//讀取TedList.txt用的
struct TeaData1 {
    var drink : String
    var price : Int
}

//讀取訂單內容用的
struct TeaData2 {
    var customer : String
    var drinks : String
    var price : String
    var size : String
    var sweet : SweetLever
    var ice : IceLever
    
    init() {
    customer = ""
    drinks = ""
    price = ""
    size = ""
    sweet = .regular
    ice = .regular
    }
}



enum SweetLever:String {
    case regular = "正常", lessSuger = "少糖", halfSuger = "半糖", quarterSuger = "微糖", sugerFree = "無糖"}

enum IceLever :String{
    case regular = "正常", moreIce = "少冰", easyIce = "微冰", iceFree = "去冰", completelyiceFree = "完全去冰", hot = "熱飲"
}

//顯示cell資料、上傳及下載sheetDB及下載資料用的
struct OrderInformation : Codable{
    var customer : String
    var drinks : String
    var price : String
    var size : String
    var sweet : String
    var ice : String
   
        
        
    init?(json: [String : Any]) {
        guard let customer = json["customer"] as? String,
            let drinks = json["drinks"] as? String,
            let size = json["size"] as? String,
            let sweet = json["sweet"] as? String,
            let ice = json["ice"] as? String,
            let price = json["price"] as? String
    
            else{
                return  nil
            }
            self.customer = customer
            self.drinks = drinks
            self.size = size
            self.sweet = sweet
            self.ice = ice
            self.price = price
         
    }
    
}
//刪除及修改sheetDB資料用的
struct Order:Encodable {
    var drinksdata: OrderInformation
}
