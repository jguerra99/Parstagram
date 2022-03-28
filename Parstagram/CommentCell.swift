//
//  CommentCell.swift
//  Parstagram
//
//  Created by Jose Lopez on 3/14/22.
//

import Foundation
import UIKit
import Parse
import AlamofireImage

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var authorPic: UIImageView!
    
    @IBOutlet weak var authorComment: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
