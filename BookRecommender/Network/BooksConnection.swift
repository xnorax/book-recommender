//
//  BooksConnection.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 13/04/2018.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit

class BooksConnection: NSObject {

    class func getBooks(categories:String, completion: @escaping (_ : Array<Book>?, _: Error?)->Void) {

        let urlString = "https://www.googleapis.com/books/v1/volumes?q=intitle:\(categories)&lang=en-us&key=AIzaSyC4UONMTKJd0XPb5zuXDrN1FRAFXpUUaUE"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!,completionHandler: { (data,response,error) in
            
            guard let data = data else { return }
            do {
            let itunesDict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                
                let resultsArray = itunesDict.object(forKey: "totalItems") as! Int
                if resultsArray != 0 {
                    var books: [Book] = []
                    let items = itunesDict.object(forKey: "items") as! [Dictionary<String, AnyObject>]
                    if items.count > 0 {
                        for item in items {
                            let info = item["volumeInfo"] as AnyObject
                            
                            let title = info["title"] as! String
                            
                            var thumbnail = ""
                            let links = info["imageLinks"] as AnyObject
                            
                            if let thumblink = links["thumbnail"] {
                                    thumbnail = thumblink as! String
                            }
                            
                            let book = Book(title: title, category: categories, thumbnail: thumbnail)
                            books.append(book)
                        }
                    }
                    completion(books,nil)
                }
            } catch {
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Error Parsing Books"])
                completion(nil, error)
                return
            }
        })
    task.resume()
    }
}
