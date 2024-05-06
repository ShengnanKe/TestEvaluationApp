//
//  QuizQuestionTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class QuizQuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameTextField: UITextField!
    var questionLabel: UILabel!
    var optionButtons: [UIButton] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        usernameTextField.placeholder = "Please enter your name here: "
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
