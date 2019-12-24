//
//  DetailTableViewController.swift
//  MyFirstPost
//
//  Created by Yvonne on 2019/12/23.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
// 從上頁傳飲料名和價格
  var teaData1: TeaData1?
// 產生的訂單資料
    var order = TeaData2 ()
   //產生訂單資料中：容量、甜度及冰度字串資料
    
   

       
     
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var sizeSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var sweetSegmentControl: UISegmentedControl!
     
    @IBOutlet weak var iceSegementControl: UISegmentedControl!
    
   
 //   let confirmOrder: [String : String] = ["customer": Order.customer, "drinks": Order.drinks, "size": Order.size, "sugar": Order.sweet.rawValue, "ice": Order.ice,  "price": Order.price]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let teaData1 = teaData1{
            drinkLabel.text? = teaData1.drink
            priceLabel.text? = teaData1.price.description
        }
        
    }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
   
    
    
    
//按下DoneButton後讀取資料
        
    @IBAction func DoneButtonPressed(_ sender: Any) {
        
        
   if  nameTextField.text?.isEmpty == true{
            let controller = UIAlertController(title: "記得填上名字哦", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller,animated: true,completion: nil)
            return
    }
//    // 收起鍵盤
    self.view.endEditing(true)
    // 從UI元件取得訂單資料
           
        print(nameTextField.text ?? "" )
        print(drinkLabel.text!)
        print(priceLabel.text!)
        
        
        order.customer = nameTextField.text ?? ""
        order.drinks = drinkLabel.text!
        order.price = priceLabel.text!
        
        if sizeSegmentControl.selectedSegmentIndex == 0 {
                       order.size = "中杯"
                   }else {
                       order.size = "大杯"
                   }
                   print("容量：\(order.size)")
        

         switch sweetSegmentControl.selectedSegmentIndex {
                   case 0:
                    order.sweet = .regular
                   case 1:
                       order.sweet = .lessSuger
                   case 2:
                       order.sweet = .halfSuger
                   case 3:
                       order.sweet = .quarterSuger
                   case 4:
                       order.sweet = .sugerFree
                   default:
                       break
                   }
        print("sweet：\(order.sweet.rawValue)")
        
        switch iceSegementControl.selectedSegmentIndex {
        case 0:
            order.ice = .regular
        case 1:
            order.ice = .moreIce
        case 2:
                order.ice = .easyIce
        case 3:
                order.ice = .iceFree
        case 4:
                order.ice = .completelyiceFree
        case 5:
            order.ice = .hot
        default:
            break
        }
         print("ice：\(order.ice.rawValue)")

// 上傳
        
        
        let url = URL(string:"https://sheetdb.io/api/v1/icvwy5qpnfi6b")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json",forHTTPHeaderField: "Content-Type")
        
        
        let confirmOrder: [String:String] = ["customer":order.customer,"drinks":order.drinks,"ice":order.ice.rawValue,"price":order.price,"size":order.size,"sweet":order.sweet.rawValue]
        let postData: [String:Any] = ["data": confirmOrder]
        
        do {
            let data  = try JSONSerialization.data(withJSONObject: postData, options: [])
            let task =  URLSession.shared.uploadTask(with: urlRequest, from: data){(retData,res,err) in
                NotificationCenter.default.post(name: Notification.Name("waitMessage"), object: nil,userInfo: ["message": true])
            }
            task.resume()
        }
        catch{
        }
    
       
            
    
        
       
                 
             }
}



