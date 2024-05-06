//
//  QuestionTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

//@IBOutlet weak var questionLabel: UILabel!
import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 22)
        //questionLabel.backgroundColor = .purple
        //questionLabel.textColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
