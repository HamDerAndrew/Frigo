//
//  ReceiptViewController.swift
//  Frigo
//
//  Created by André Larsen on 05/02/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class ReceiptViewController: UIViewController {
    
    @IBOutlet weak var purchasedProduct: UILabel!
    @IBOutlet weak var purchasedProductPrice: UILabel!
    @IBOutlet weak var purchasedSum: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    
    var paidProduct: String?
    var paidPrice: Int?
    var paidAmount: Int?
    var total: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let price = paidPrice, let amount = paidAmount {
            total = price * amount
        }
        
        purchasedProduct.text = "\(paidAmount ?? 0) x \(paidProduct ?? "Intent produkt")"
        purchasedProductPrice.text = "\(total ?? 0) kr."
        purchasedSum.text = "\(total ?? 0) kr."
        
        getDate()
    }
    
    //Hide the top navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    //Show the top navigation bar again when the view is destroyed.
    //This is so the top nav bar is still shown on the other views.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        
        /*A hacky solution for navigating to the ProductsViewController, but the top par dissappears when doing it this way*/
        //let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        //self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
    }
    
    func getDate() {
        //Date
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy"
        let formattedDate = format.string(from: date)
        purchaseDate.text = String(formattedDate)
    }

}
