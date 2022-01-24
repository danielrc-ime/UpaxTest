//
//  EditTextTableViewCell.swift
//  UpaxTest
//
//  Created by Daniel iOS on 21/01/22.
//

import UIKit

class EditTextTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var editText: UITextField!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.contains("") {
            return true
        }
        
        if string.rangeOfCharacter(from: NSCharacterSet.letters) != nil {
            return true
        }
        else {
            return false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        editText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
