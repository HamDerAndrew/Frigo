//
//  ProductManager.swift
//  Frigo
//
//  Created by André Larsen on 30/01/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import Foundation
import UIKit


struct ProductManager {
    
    let productsUrl = "https://staging.appcms.dk/api/cX8hvUC6GEKGgUuvzsBCNA/content/da"
    
    //I wanted to make this work in this "Manager" file, but I couldn't find a way to reload the view once the data was fetched.
    //Therefore I put the below function in the ProductsViewController. I left it here to let you know that I tried ^^
    func getProducts() -> [ProductCell] {
        
        let decoder = JSONDecoder()
        var theArray = [ProductCell]()
        
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
                        //Create SWIFT Data object from the Json
                        let decodedJson = try decoder.decode(ProductModel.self, from: safeData)
                        let itemsArray = decodedJson.data.products.items
                        
                        for product in itemsArray {
                            let theObj = ProductCell(Title: product.title, Price: product.price, listImage: product.list_image.file_url, bigImage: product.big_image.file_url)
                            print("Append \(theArray.count)")
                            theArray.append(theObj)
                            print("Did Append")
                        }
                    } catch {
                        print(error)
                    }
                    print("AFTER LOOP \(theArray)")
                }
                
                print("OUTSIDE DATA \(theArray)")
            }
            //4. Start the task
            task.resume()
            print("AFTER RESUME\(theArray)")
        }
        //IT GOES WRONG HERE
        print("JUST BEFORE RETURN \(theArray)")
        
        return theArray
    }
    
}
