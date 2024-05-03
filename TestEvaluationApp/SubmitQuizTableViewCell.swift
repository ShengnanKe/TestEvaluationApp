//
//  SubmitQuizTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/2/24.
//

import UIKit

class SubmitQuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        submitButton.setTitle("Submit Question", for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var submitAction: (() -> Void)?
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        submitAction?()
    }
    
    
    
}
