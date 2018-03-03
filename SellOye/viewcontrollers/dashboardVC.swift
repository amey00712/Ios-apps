//
//  dashboardVC.swift
//  SellOye
//
//  Created by Amey Kothavale on 27/02/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SlideMenuControllerSwift


var orderArray = [JSON]()
var notificationArray = [JSON]()
var productArray = [JSON]()


class dashboardVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var scroller: UIScrollView!
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1
        {
        return orderArray.count
        }
        
        else if collectionView.tag == 2{
            return notificationArray.count
        }
        else{
        
        return productArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView.tag == 1 {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! orderCell
        cell.invoiceLabel.text? = String (describing: orderArray[indexPath.row]["invoice_no"])
        cell.amountLabel.text = "₹" + String (describing: orderArray[indexPath.row]["amount"]) + "  " +  String (describing: orderArray[indexPath.row]["status"])
            
        return cell

        }
        
        else if collectionView.tag == 2{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notify", for: indexPath) as! notificationCell
            cell.nameLabel.text = String(describing: notificationArray[indexPath.row]["name"])
            cell.priceLabel.text = "₹" + String(describing: notificationArray[indexPath.row]["price"])
            
            // Setting image from url
           let imageStr = String(describing: notificationArray[indexPath.row]["path"]) + String(describing: notificationArray[indexPath.row]["image"])
            let url = URL(string : imageStr)
            if let data = try? Data(contentsOf: url!)
            {
                cell.poductImageView.image = UIImage(data:data)
            }
            return cell

         }
        
        else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as! productCell
            cell.nameLabel.text = String(describing: productArray[indexPath.row]["name"])
            cell.priceLabel.text = String (describing: productArray[indexPath.row]["price"])
            
            // Setting image from url
            let imageStr = String(describing: productArray[indexPath.row]["path"]) + String(describing: productArray[indexPath.row]["image"])
            let url = URL(string : imageStr)
            if let data = try? Data(contentsOf: url!)
            {
                cell.productImageView.image = UIImage(data:data)
            }
           
            return cell
            
        }
        
    }
    

    @IBOutlet weak var orderCollectionView: UICollectionView!
    @IBOutlet weak var notificationCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        UserDefaults.standard.set(true, forKey: "firstRunCompleted")
        
        self.view .addSubview(loadingView)
        self.loadingView.addSubview(loader)
        
        orderCollectionView.tag = 1
        notificationCollectionView.tag = 2
        productCollectionView.tag = 3
        
        scroller.isScrollEnabled = true
        scroller.contentSize = CGSize(width : self.view.frame.size.width , height : 1000)
        orderLabel.frame = CGRect(x:20 ,y:50,width:orderLabel.bounds.size.width,height:orderLabel.bounds.size.height)
        
        orderButton.frame = CGRect(x:self.view.frame.size.width - 80 ,y:45,width:orderButton.bounds.size.width,height:orderButton.bounds.size.height)

        orderCollectionView.frame = CGRect(x:0 ,y:orderLabel.frame.origin.y + orderLabel.frame.size.height ,width: self.view.frame.size.width,height:orderCollectionView.bounds.size.height)

        notificationLabel.frame = CGRect(x:20 ,y:orderCollectionView.frame.origin.y + orderCollectionView.frame.size.height + 15 ,width: self.view.frame.size.width,height:notificationLabel.bounds.size.height)
        
        notificationButton.frame = CGRect(x:self.view.frame.size.width - 80 ,y:notificationLabel.frame.origin.y - 5,width:notificationButton.bounds.size.width,height:notificationButton.bounds.size.height)

        notificationCollectionView.frame = CGRect(x:0 ,y:notificationLabel.frame.origin.y + notificationLabel.frame.size.height  ,width: self.view.frame.size.width,height:notificationCollectionView.bounds.size.height)

        productLabel.frame = CGRect(x:20 ,y:notificationCollectionView.frame.origin.y + notificationCollectionView.frame.size.height + 5 ,width: self.view.frame.size.width,height:productLabel.bounds.size.height)
        
        productButton.frame = CGRect(x:self.view.frame.size.width - 80 ,y:productLabel.frame.origin.y - 5,width:productButton.bounds.size.width,height:productButton.bounds.size.height)


        productCollectionView.frame = CGRect(x:0 ,y:productLabel.frame.origin.y + productLabel.frame.size.height  ,width: self.view.frame.size.width,height:productCollectionView.bounds.size.height)
        
        
        

        let id = (UserDefaults.standard.value(forKey: "allDetails") as AnyObject).value(forKey: "dealer_id")!
        
        let url = "http://selloye.com/api/Api/my_dashboard"
        
        let parameters: Parameters = ["dealer_id" : id]

        Alamofire.request(url, method:.post, parameters:parameters).responseJSON { response in
            switch response.result {
            case .success:
                
                self.loadingView.isHidden = true
                let json :JSON = JSON(response.result.value ?? "")
                orderArray = json["orders"].array!
                notificationArray = json["notification"].array!
                productArray = json["all_product"].array!

                self.orderCollectionView .reloadData()
                self.notificationCollectionView .reloadData()
                self.productCollectionView .reloadData()

              
            case .failure(let error):
                print(error)
            }
        
    }
        
        self .subViews()
}
    
    
    let loadingView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    
    let loader : UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.black
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    func subViews(){
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor, constant : 64).isActive = true
        loadingView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loadingView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    

}
