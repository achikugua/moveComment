//
//  MovieTableViewCell.swift
//  movieComment
//
//  Created by Apple on 2018/12/18.
//  Copyright © 2018年 xvting. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var goodNum: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
