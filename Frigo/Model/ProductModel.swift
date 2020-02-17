//
//  ProductModel.swift
//  Frigo
//
//  Created by André Larsen on 29/01/2020.
//  Copyright © 2020 André Larsen. All rights reserved.
//

import Foundation
import UIKit


struct ProductModel: Codable {
    let meta_data: MetaData
    let data: ProductData
}


struct MetaData: Codable {
    
}


struct ProductData: Codable {
    let products: Products
}


struct Products: Codable {
    let id: Int
    let items: [Items]
    let title: String
    let _fields: Fields
}


struct Items: Codable {
    let id: Int
    let price: String
    let title: String
    let big_image: BigImage
    let list_image: ListImage
}


struct Fields: Codable {
    let price: String
    let title: String
    let big_image: String
    let list_image: String
}

struct BigImage: Codable {
    let file_url: String
    let file_name: String
    let file_size: Int
    let file_type: String
}

struct ListImage: Codable {
    let file_url: String
    let file_name: String
    let file_size: Int
    let file_type: String
}
