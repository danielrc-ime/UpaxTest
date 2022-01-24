//
//  ColorsTableViewCell.swift
//  UpaxTest
//
//  Created by Daniel iOS on 22/01/22.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {
    
    var button1 : (() -> ()) = {}
    var button2 : (() -> ()) = {}
    var button3 : (() -> ()) = {}
    var button4 : (() -> ()) = {}
    
    @IBOutlet weak var buttonOrange: UIButton!
    @IBOutlet weak var buttonPink: UIButton!
    @IBOutlet weak var buttonPurple: UIButton!
    @IBOutlet weak var buttonGreen: UIButton!
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            button1()
        case 2:
            button2()
        case 3:
            button3()
        case 4:
            button4()
        default:
            break
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
