//
//  AllCommentsView.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/15/22.
//

import Foundation
import UIKit
import Parse
import MessageInputBar
import AlamofireImage

class AllCommentsView: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    let commentbar = MessageInputBar()
    var showsCommentBar = false
    var post: PFObject!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        commentbar.sendButton.title = "Post"
        commentbar.inputTextView.placeholder = "Add a Comment..."
        commentbar.delegate = self
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWilBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWilBeHidden(note: Notification){
        commentbar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()

    }
    override var inputAccessoryView: UIView? {
        return commentbar
    }
    override var canBecomeFirstResponder: Bool{
        return true
        
    }
   func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
       let comment = PFObject(className: "Comments")
                comment["text"] = text
                comment["post"] = post
               comment["author"] = PFUser.current()!
                post.add(comment, forKey: "comments")
               post.saveInBackground { (success, error) in
                    if success{
                        print("comment was saved")
                    }else{
                        print("error")
                }
    }
        tableView.reloadData()
        commentbar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentbar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let comments = (post["comments"] as? [PFObject]) ?? []

         return comments.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let comments = (post["comments"] as? [PFObject]) ?? []
       let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
       let comment = comments[indexPath.row]
           cell.authorComment.text = comment["text"] as? String
        let user = comment["author"] as! PFUser
        cell.authorName.text = user.username
        let useravatar = user["profilepic"] as? PFFileObject
        useravatar?.getDataInBackground{ (imageData, error)in
            DispatchQueue.main.async {
              if imageData != nil, error == nil {
                let image = UIImage(data: imageData!)
                  cell.authorPic.image = image
                  

              }
           }
    }

            return cell

        }
}
    

    
    

