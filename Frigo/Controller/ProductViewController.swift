//
//  ProductViewController.swift
//  Frigo
//
//  Created by André Larsen on 01/02/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productTotalPrice: UILabel!
    @IBOutlet weak var productAmount: UILabel!
    @IBOutlet weak var purchaseBtn: UIButton!
    @IBOutlet weak var productContainer: UIView!
    
    var product: ProductCell?
    var amount: Int = 1
    var price: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productAmount.text = "\(amount)"
        
        //convert price to kr.
        let priceString = product?.Price
        let convertToInt = Int(priceString!)
        price = convertToInt! / 100
        
        //grab "big image" from the URL
        guard let imageURL = URL(string: product!.bigImage) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        let image = UIImage(data: imageData)
        
        productName.text = product?.Title
        productTotalPrice.text = "\(price) kr"
        productImage.image = image
        
        //productAmount styling
        productAmount.layer.cornerRadius = 8.0
        productAmount.clipsToBounds = true
        productAmount.layer.borderWidth = 2
        productAmount.layer.borderColor = UIColor(red: 156.0/255.0, green: 160.0/255.0, blue: 195.0/255.0, alpha: 1.0).cgColor
        
    }
    
    @IBAction func increaseAmount(_ sender: UIButton) {
        amount += 1
        productAmount.text = "\(amount)"
        productTotalPrice.text = "\(amount * price) kr"
    }
    
    @IBAction func decreaseAmount(_ sender: UIButton) {
        if(amount <= 1) {
            return
        }
        amount -= 1
        productAmount.text = "\(amount)"
        productTotalPrice.text = "\(amount * price) kr"
    }
    
    @IBAction func purchasePressed(_ sender: UIButton) {
        purchaseBtn.backgroundColor = UIColor(displayP3Red: 0.0/255, green: 29.0/255, blue: 209.0/255, alpha: 1.0)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(buttonClickAnimation), userInfo: nil, repeats: false)
        performSegue(withIdentifier: "awaitConfirmation", sender: self)
        
    }
    
    @objc func buttonClickAnimation() {
        purchaseBtn.backgroundColor = UIColor(red: 21.0/255, green: 60.0/255, blue: 209.0/255, alpha: 1.0)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProcessingViewController {
            destination.name = productName.text
            destination.price = price
            destination.amount = amount
        }
    }

}
