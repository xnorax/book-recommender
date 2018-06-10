//
//  Book.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 14/04/2018.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit

class Book: NSObject {
    let categories = ["entertainment","non-fiction","financial investment","autobiography"]
    let categoryColors = [
        0: UIColor.red, 1: UIColor.green
    ]
    var title:String!
    var category:String!
    var categoryColor:UIColor!
    var thumbnail:String!
    
    init(title:String, category:String, thumbnail:String){
        super.init()
        self.title = title
        self.category = category
        self.thumbnail = thumbnail
    }
    
}
