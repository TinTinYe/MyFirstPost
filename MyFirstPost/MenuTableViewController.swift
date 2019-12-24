//
//  MenuTableViewController.swift
//  MyFirstPost
//
//  Created by Yvonne on 2019/12/23.
//  Copyright © 2019 Yvonne. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var teaData1s = [TeaData1]()
    
    func getTeaData1() {
        if let url = Bundle.main.url(forResource: "TeaList", withExtension: "txt"),let content = try? String(contentsOf: url){
            //利用components將換行移除
            let array1 = content.components(separatedBy: "\n")
            for number in 0..<array1.count{
                if number % 2 == 0{
                    let drink = array1[number]
                    if let price = Int(array1[number+1]){
                        teaData1s.append(TeaData1(drink: drink, price: price))
                    }
                    else{
                        print ("fail")
                    }
            }
            
    }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     getTeaData1()
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

            
            
            
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teaData1s.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        let teaData1 = teaData1s[indexPath.row]
        cell.textLabel?.text = teaData1.drink
        cell.detailTextLabel?.text = teaData1.price.description
       

        // Configure the cell...

        return cell
    }
 

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailTableViewController,let row = tableView.indexPathForSelectedRow?.row{
            controller.teaData1 = teaData1s[row]
//           controller.priceLabel.text = teaData1s[row].price.description
        }
    }
    
    
}

