//
//  TwitterConnection.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 4/13/18.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit
import SwifteriOS

extension String {
    var wordList: [String] {
        return components(separatedBy: NSCharacterSet.alphanumerics.inverted).filter({!$0.isEmpty})
    }
}


class TwitterConnection: NSObject {
    
    class func getTweetsForUsername(username:String, completion: @escaping (_ : String?, _: Error?)->Void) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.swifter?.searchTweet(using: username, success: { json,somethingelse in
            guard let tweets = json.array else { return }
            var buffer = ""
            
            if(tweets.count == 0){
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Could not find any tweet"])
                completion(nil, error)
                return
            }
            
            for tweet in tweets {
                let text = self.cleanTweet(tweetText: tweet["text"].string!)
                buffer.append(" \(text)")
            }
            
            if(buffer.count <= 100){
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Less than 100 tweets"])
                completion(nil, error)
                return
            }
            
            completion(buffer,nil)
            
        }){ (error) in
            completion(nil, error)
        }
    }
    
    class func cleanTweet(tweetText:String)->String{
        
        // Break down the tweet into words
        var words = tweetText.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        // Remove retweet and mentions
        words = words.filter{$0 != "RT"}
        words = words.filter{ !$0.hasPrefix("@") }
        words = words.filter{ !$0.contains("https") }
        
        // Append the words into one sentence again
        var sentence = ""
        if (!words.isEmpty){
        sentence.append(words.first!)
        for word in words.dropFirst() {
            sentence.append(" \(word)")
            }
        }
        return sentence
    }
    
    

}
