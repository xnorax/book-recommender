//
//  ViewController.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 3/24/18.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate=self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        recommendBooks()
        return true
    }
    
    @IBAction func search(_ sender: Any) {
        textField.resignFirstResponder()
        recommendBooks()
    }
    
    func recommendBooks(){
        
        // TODO: check correctness of twitter username
        
        // TODO: remove @
        
        // start activity indecator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        TwitterConnection.getTweetsForUsername(username: textField.text!) { (tweets, error) in
            
            if error != nil {
                DispatchQueue.main.async() {
                self.activityIndicator.stopAnimating()
                self.showAlert(title: "Twitter", message: (error?.localizedDescription)!)
                }
                return
            }
            
            WatsonConnection.getPersonality(mainVC: self, text: tweets!) { (query,error) -> () in
                
                if error != nil {
                    DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                    self.showAlert(title: "Watson Personality Insight", message: (error?.localizedDescription)!)
                    }
                    return
                }
                
                BooksConnection.getBooks(categories: query!) { (books,error) -> () in
                    
                    if error != nil {
                        DispatchQueue.main.async() {
                            self.activityIndicator.stopAnimating()
                        self.showAlert(title: "Google Books", message: (error?.localizedDescription)!)
                        }
                        return
                    }
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "booksView") as! BooksViewController
                    newViewController.booksArray = books!
                   DispatchQueue.main.async() {
                        self.activityIndicator.stopAnimating()
                    self.navigationController!.pushViewController(newViewController, animated: true)
                    }
                    
                }
              }// End of getPersonality
        }// End of getTweetsForUsername
    }// End of Function
    
    
    func showAlert(title:String, message:String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}// End of Class

