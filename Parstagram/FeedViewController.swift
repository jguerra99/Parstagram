//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/15/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    
    
    let myRefreshControl = UIRefreshControl()
    var numberOfPosts: Int!
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    var selectedPost: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.insertSubview(myRefreshControl, at: 0)
        tableView.refreshControl = myRefreshControl
        tableView.keyboardDismissMode = .interactive
        
        // Do any additional setup after loading the view.
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
                self.tableView.reloadData()
            }
            
        
    }
        
        self.myRefreshControl.endRefreshing()
    }
    @objc func loadMorePosts(){
       numberOfPosts = numberOfPosts + 20
        let query = PFQuery(className:"Posts")
        query.includeKeys(["author","comments","comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error)  in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        
    }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        
        let post = posts[indexPath.section]
         let user = post["author"] as! PFUser
        let useravatar = user["profilepic"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            DispatchQueue.main.async {
              if imageData != nil, error == nil {
                let image = UIImage(data: imageData!)
                  cell.profilePic.image = image
                  

              }
           }
    }
         cell.usernameLabel.text = user.username
        cell.firstusernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as? String
         let imageFile = post["image"] as! PFFileObject
         let urlString = imageFile.url!
         let url = URL(string: urlString)!
         cell.photoView.af.setImage(withURL: url)
         return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
            selectedPost = post
    
    }

    
    func tableiew(_tableView:UITableView, willDisplay cell:UITableViewCell, forRowAt  indexPath: IndexPath){
        if indexPath.row + 1 == posts.count{
          loadMorePosts()
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
                UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.section]
        
        let commentsViewController = segue.destination as! AllCommentsView
        commentsViewController.post = post
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

}

