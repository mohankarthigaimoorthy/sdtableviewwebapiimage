//
//  myTableViewCell.swift
//  sdWebImage
//
//  Created by Mohan K on 13/02/23.
//

import UIKit

class myTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imgImage.image = nil
    }
}
