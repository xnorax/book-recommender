//
//  BooksView.swift
//  BookRecommender
//
//  Created by Nora AlNashwan on 3/27/18.
//  Copyright © 2018 Nora AlNashwan. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var booksArray : [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenHeight/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
//        //Define Layout here
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//
//        //Get device width
//        let width = UIScreen.main.bounds.width
//
//        //set section inset as per your requirement.
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//
//        //set cell item size here
//        layout.itemSize = CGSize(width: width / 2, height: width / 2)
//
//        //set Minimum spacing between 2 items
//        layout.minimumInteritemSpacing = 0
//
//        //set minimum vertical line spacing here between two lines in collectionview
//        layout.minimumLineSpacing = 0
//
//        //apply defined layout to collectionview
//        collectionView.collectionViewLayout = layout
    
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BookCell
        
        let index = indexPath.section+indexPath.row
        cell.title.text = booksArray[index].title ?? "no title"
        cell.category.text = "#"+(booksArray[index].category ?? "no cat")
        
        if (!booksArray[index].thumbnail.isEmpty){
        
        let url = URL(string:booksArray[index].thumbnail)
        
            if url?.absoluteString != nil {
                do {
                    let data = try Data(contentsOf: url!)
                    cell.thumbnail.image = UIImage(data: data)
                }catch{
                    //
                }
            }
        }
        
        return cell
    }

    
}
