//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/15/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tabBar: UITabBar!
    
    let myRefreshControl = UIRefreshControl()
    var numberOfPosts: Int!
    @IBOutlet weak var tableView: UITableView!
   
    @objc var posts = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.insertSubview(myRefreshControl, at: 0)
        tableView.refreshControl = myRefreshControl
        self.registerTableViewCells()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPosts()
    }
    private func registerTableViewCells() {
        
        let feedCell = UINib(nibName: "PostCell", bundle: nil)
        
        self.tableView.register(feedCell, forCellReuseIdentifier: "PostCell")
    }
    
    @objc func loadPosts(){
        numberOfPosts = 20
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
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
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error)  in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        
    }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
         let post = posts[indexPath.row]
         let user = post["author"] as! PFUser
         cell.usernameLabel.text = user.username
         cell.captionLabel.text = post["caption"] as! String
         let imageFile = post["image"] as! PFFileObject
         let urlString = imageFile.url!
         let url = URL(string: urlString)!
         cell.photoView.af.setImage(withURL: url)
         return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? PostCell

        if cell == nil {
            return
        }
    }
        
       /* let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af.setImage(withURL: url)
        return cell
    }
        */
    func tableiew(_tableView:UITableView, willDisplay cell:UITableViewCell, forRowAt  indexPath: IndexPath){
        if indexPath.row + 1 == posts.count{
            loadMorePosts()
        }
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
                UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

