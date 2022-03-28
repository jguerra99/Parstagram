//
//  SearchFeedGrid.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/22/22.
//

import Foundation
import UIKit
import Parse


class SearchGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var posts = [PFObject]()
    var numberOfPosts: Int!
    
    @IBOutlet weak var postPicView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        postPicView.delegate = self
             postPicView.dataSource = self
             let layout = postPicView.collectionViewLayout as! UICollectionViewFlowLayout
             
              layout.minimumLineSpacing = 10
              layout.minimumInteritemSpacing = 0
              let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
             layout.itemSize = CGSize(width: width, height: width * 3 / 2)
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
    }
    @objc func loadPosts(){
        numberOfPosts = 20
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author","comments","comments.author", "profilepic"])

        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error)  in
            if posts != nil{
                self.posts = posts!
                self.postPicView.reloadData()
            }
            
        
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFeedCell", for: indexPath) as! SearchFeedCell
              
        let post = posts[indexPath.item]
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.postPicCell.af.setImage(withURL: url)
             
              return cell
    }
    
}
