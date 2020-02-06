//
//  CustomProductCell.swift
//  Frigo
//
//  Created by André Larsen on 04/02/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class CustomProductCell: UITableViewCell {

    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        cellContainer.layer.borderWidth = 5
//        cellContainer.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
