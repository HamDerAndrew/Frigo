//
//  FirstViewController.swift
//  Frigo
//
//  Created by André Larsen on 28/01/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let productManager = ProductManager()
    let productsUrl = "https://staging.appcms.dk/api/cX8hvUC6GEKGgUuvzsBCNA/content/da"
    let cellSpacingHeight: CGFloat = 10
    
    var productsArray = [ProductCell]()
    var selectedProduct: CustomProductCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide back button when u come from the receipt page
        navigationItem.hidesBackButton = true
        
        //Set the data source for the TableView. It will be ProductsViewController (the 'self').
        tableView.dataSource = self
        
        //Set the delegate for the TableView. It will be ProductsViewController (the 'self').
        tableView.delegate = self
        
        //register CustomProductCell to be available for the tableView
        tableView.register(UINib(nibName: "CustomProductCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        productsArray = getProducts()
        
    }
    
    //Hide back button on tabnavigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = "Produkter"
    }
    
    func getProducts() -> [ProductCell] {
        
        let decoder = JSONDecoder()
        
        //1. Create a URL
        if let url = URL(string: productsUrl) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task - session.dataTask function param is passed as a closure here.
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    
                    do {
                        //Create SWIFT Data object from the Json?
                        let decodedJson = try decoder.decode(ProductModel.self, from: safeData)
                        let itemsArray = decodedJson.data.products.items
                        
                        for product in itemsArray {
                            //print("\(product.title): \(product.price)")
                            let theObj = ProductCell(Title: product.title, Price: product.price, listImage: product.list_image.file_url, bigImage: product.big_image.file_url)
                            self.productsArray.append(theObj)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        return productsArray
    }
    
    
    
}

//Needed to populate the TableView with data. It is responsible for that.
extension ProductsViewController: UITableViewDataSource {
    
    //Use sections instead of rows to be able to add spacing between the products
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productsArray.count
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    //Asking a UITableViewCell what to display in each row of the TableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomProductCell
        
        //convert price to kr.
        let priceString = productsArray[indexPath.section].Price
        let convertToInt = Int(priceString)
        let priceInKr = convertToInt! / 100
        
        //add data to the cell
        cell?.productName.text = productsArray[indexPath.section].Title
        cell?.productPrice.text = ("\(priceInKr) kr.")
        if let imageURL = URL(string: productsArray[indexPath.section].listImage) {
            //get image on the background thread
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let safeData = data {
                    let image = UIImage(data: safeData)
                    //switch back to the mainthread and present the image
                    DispatchQueue.main.async {
                        cell?.productImage?.image = image
                    }
                }
            }
        }
        
        //Styling
        cell?.backgroundColor = UIColor.white
        cell?.layer.borderColor = UIColor.clear.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true
        
        return cell!
    }
    
}


//Extension for when a TableView is interacted with
extension ProductsViewController: UITableViewDelegate {
    
    //Do something when a user selects a cell (row)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "productDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProductViewController {
            destination.product = productsArray[(tableView.indexPathForSelectedRow?.section)!]
        }
    }
    
}
