//
//  QuizQuestionTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/1/24.
//

import UIKit

class QuizQuestionTableViewCell: UITableViewCell {
        
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
