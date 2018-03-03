//
//  orderVC.swift
//  SellOye
//
//  Created by Amey Kothavale on 01/03/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SlideMenuControllerSwift

class orderVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var orderArray = NSArray()
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = "http://selloye.com/api/Api/all_order"
        let id = (UserDefaults.standard.value(forKey: "allDetails") as AnyObject).value(forKey: "dealer_id")
        let param : Parameters = ["dealer_id":id!]

        Alamofire.request(url, method: .post, parameters:param).responseJSON{
            response in
            
            if response.result.isSuccess{
                
                let arr = response.result.value as! NSArray
                
                self.orderArray = arr as NSArray
            //    print(self.orderArray)
                self.table.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! orderTableCell
      
        
        cell.invoiceLabel.text = (orderArray[indexPath.row] as AnyObject).value(forKey: "invoice_no") as? String
        cell.priceLabel.text = (orderArray[indexPath.row] as AnyObject).value(forKey: "amount") as? String
        cell.statusLabel.text = (orderArray[indexPath.row] as AnyObject).value(forKey: "status") as? String
        cell.dateLabel.text = (orderArray[indexPath.row] as AnyObject).value(forKey: "added_date") as? String

        cell.dateLabel.sizeToFit()
        cell.viewProductButton.tag = indexPath.row
        cell.viewProductButton.addTarget(self, action:#selector(self.viewProductButtonPressed(sender:)) , for: UIControlEvents.touchUpInside)
        
        return cell
    }

    
    @objc func viewProductButtonPressed(sender:UIButton){
        
        let orderID = (orderArray[sender.tag] as AnyObject).value(forKey: "order_id")
        
     
        
        let story = UIStoryboard(name : "Main" , bundle : nil)
        let vc = story.instantiateViewController(withIdentifier: "orderOnePopUp") as! orderOnePopUp
        self.present(vc, animated: true, completion: nil)
        
        /*  let url = "http://selloye.com/api/Api/my_order_products"
        let param : Parameters = ["order_id" : orderID as! String]
        
        Alamofire.request(url , method: .post , parameters : param).responseJSON{
            
            respons in
            
            if respons.result.isSuccess{
                print(respons.result.value!)
            }
            
        } */
        
        print(orderID!)
    }
    
    @IBAction func drawerButtonPressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    
}
