//
//  FeedbackTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        feedbackLabel.numberOfLines = 0
        feedbackLabel.textAlignment = .center
        feedbackLabel.font = UIFont.systemFont(ofSize: 22)
        feedbackLabel.textColor = .white
        feedbackLabel.backgroundColor = .purple
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedbackLabel.isHidden = true
        feedbackLabel.text = nil
        feedbackLabel.textColor = .white
    }

    func configureFeedback(isCorrect: Bool, correctAnswer: String) {
        feedbackLabel.isHidden = false
        feedbackLabel.text = isCorrect ? "Correct!" : "Incorrect! The correct answer was \(correctAnswer)."
        feedbackLabel.textColor = isCorrect ? .green : .red
    }
}
