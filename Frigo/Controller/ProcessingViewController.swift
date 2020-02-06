//
//  ProcessingViewController.swift
//  Frigo
//
//  Created by André Larsen on 01/02/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class ProcessingViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    var name: String?
    var price: Int?
    var amount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(navigateToReceipt), userInfo: nil, repeats: false)
        
        //There is a "hacky" solution for an animation, but it works for now ^^
        UIView.animate(withDuration: 1, animations: {
            self.activityIndicator.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi)))
         }) { (isAnimationComplete) in

        // Nested Block
        UIView.animate(withDuration: 1) {
            self.activityIndicator.transform = CGAffineTransform(rotationAngle: (CGFloat(Double.pi * 2)))
               }
        }
        
        //Animate "Processing..."
        activityLabel.text = ""
        var charIndex = 0.0
        let titleText = "Processing..."
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.activityLabel.text?.append(letter)
            }
            //using charIndex to delay the animation of the 'titleText' animation
            charIndex += 1
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ReceiptViewController {
            destination.paidProduct = name
            destination.paidPrice = price
            destination.paidAmount = amount
        }
    }
    
    @objc func navigateToReceipt() {
         performSegue(withIdentifier: "reciptView", sender: self)
    }

}
