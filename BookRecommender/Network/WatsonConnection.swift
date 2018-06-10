//
//  WatsonConnection.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 13/04/2018.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit
import PersonalityInsightsV3

class WatsonConnection: NSObject {
    
    class func getPersonality(mainVC:ViewController, text:String, completion: @escaping (_ : String?, _: Error?)->Void) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let categoriess = ["Entertainment","Nonfiction","Finance","Autobiography"]
        
        delegate.personalityInsights?.profile(text: text, consumptionPreferences: true, failure: { (error) in
            completion(nil, error)
        }){ profile in
            guard let preferences = profile.consumptionPreferences else {
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Could not find any preferences"])
                completion(nil, error)
                return
            }
            let consumption = preferences[6]
            var query = ""
            var count = 0
            for (index,node) in consumption.consumptionPreferences.enumerated() {
                if (index != 0 && node.score == 1.0 && count == 0){
                    count=count+1
                    query.append(categoriess[index-1])
                }
            }
            
            if (count==0){
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Could not find any preferences"])
                completion(nil, error)
                return
            }
            
            completion(query,nil)
        }
    }
}
