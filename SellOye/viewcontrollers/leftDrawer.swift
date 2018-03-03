//
//  leftDrawer.swift
//  SellOye
//
//  Created by Amey Kothavale on 26/02/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
var arr = Array<String>()

class leftDrawer: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    
    @IBOutlet weak var table: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
     arr = ["Home","Orders","Earnings","Product","Notification","About us","contact us","Support"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! leftDrawerCell
       // cell.t = arr[indexPath.row]
        cell.titleLabel.text = arr[indexPath.row]
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story = UIStoryboard(name : "Main" , bundle : nil)

        
        switch indexPath.row {
        
       
        case 0:
            
            let vc = story.instantiateViewController(withIdentifier: "dashboardVC") as! dashboardVC
            self.slideMenuController()?.changeMainViewController(vc, close: true)
        
        
        case 1:
            
            let vc = story.instantiateViewController(withIdentifier: "orderVC") as! orderVC
            self.slideMenuController()?.changeMainViewController(vc, close: true)
            
        case 2:
            let vc = story.instantiateViewController(withIdentifier: "earningVC") as! earningVC
            self.slideMenuController()?.changeMainViewController(vc, close: true)
        
        default:
            print("default")
        }
       
    }
    
    func accessViewController(viewController : ViewController , string : String){
        
    }

    
}




