//
//  PicTableViewCell.swift
//  UpaxTest
//
//  Created by Daniel iOS on 21/01/22.
//

import UIKit

class PicTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var labelSelfie: UILabel!
    
    @IBOutlet weak var imagePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
