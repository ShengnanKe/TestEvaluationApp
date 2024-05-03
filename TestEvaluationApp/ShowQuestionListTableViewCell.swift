//
//  ShowQuestionListTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/3/24.
//

import UIKit

class ShowQuestionListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showQuestionListButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        showQuestionListButton.setTitle("Show Question List", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var showQuestionListAction: (() -> Void)?
    
    @IBAction func showQuestionListButtonTapped(_ sender: UIButton) {
        showQuestionListAction?()
    }
    

}
