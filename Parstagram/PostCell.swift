//
//  PostCell.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/17/21.
//

import UIKit
import Parse

class PostCell: UITableViewCell {
    
    @objc var posts = [PFObject]()
    
    @IBOutlet weak var firstusernameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var viewComment: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        profilePic.makeRounded()
        self.selectionStyle = .none
        // Initialization code
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
