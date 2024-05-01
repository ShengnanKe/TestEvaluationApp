//
//  SignUpTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 4/30/24.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testTakerLabel: UILabel!
    @IBOutlet weak var testTakerTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
