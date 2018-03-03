//
//  orderTableCell.swift
//  SellOye
//
//  Created by Amey Kothavale on 01/03/18.
//  Copyright © 2018 Amey Kothavale. All rights reserved.
//

import UIKit

class orderTableCell: UITableViewCell {

    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewProductButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
   /* let productButton : UIButton = {
       
        let btn = UIButton()
        btn.setTitle("VIEW PRODUCTS", for: UIControlState.normal)
        
        return btn
        
    }() */
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
