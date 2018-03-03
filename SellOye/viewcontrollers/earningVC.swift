//
//  earningVC.swift
//  SellOye
//
//  Created by Amey Kothavale on 01/03/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SlideMenuControllerSwift


class earningVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    var earningArray = [JSON]()

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var filteredData = [JSON]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        search.delegate = self
        search.returnKeyType = UIReturnKeyType.done
        
        let url = "http://selloye.com/api/Api/all_earning"
        let id = (UserDefaults.standard.value(forKey: "allDetails") as AnyObject).value(forKey: "dealer_id")!
        let params : Parameters = ["dealer_id" : id]
        
        Alamofire.request(url , method: .post , parameters : params).responseJSON{
            response in
            
            if response.result.isSuccess{
              
                let json : JSON = JSON(response.result.value ?? "")
                self.earningArray = json.array!
                self.table.reloadData()
            }
            else{
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      /*  if isSearching {
            return filteredData.count

        } */
        return earningArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! earningCell
        
        
        
       /* if isSearching{
            cell.nameLabel.text =  String(describing: filteredData[indexPath.row]["name"])

        } */
        
        
        cell.nameLabel.text = String (describing: earningArray[indexPath.row]["name"])
        cell.invoiceLabel.text = "Invoice no : " + String (describing: earningArray[indexPath.row]["invoice_no"])
        cell.priceLabel.text = "₹ " + String (describing: earningArray[indexPath.row]["price"])
        cell.statusLabel.text = String (describing: earningArray[indexPath.row]["status"])
        
        // setting image
        
        let imgStr = String (describing: earningArray[indexPath.row]["path"]) + String (describing: earningArray[indexPath.row]["image"])
        let url = URL(string : imgStr)
        if let data = try? Data(contentsOf: url!)
        {
            cell.productImageView.image = UIImage(data:data)
        }
        
        return cell
    }
    
    @IBAction func drawerButtonPressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    /*  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            
        }else{
            filteredData = earningArray.filter({$0 == searchBar.text})
        }
    } */

}
