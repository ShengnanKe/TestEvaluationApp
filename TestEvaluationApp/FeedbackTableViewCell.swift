//
//  FeedbackTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {
    let feedbackLabel = UILabel() // Declare it here to use across all methods in this class
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFeedbackLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        feedbackLabel.isHidden = true
        feedbackLabel.text = nil
        feedbackLabel.textColor = .white
    }

    private func setupFeedbackLabel() {
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false  // Use auto layout
        contentView.addSubview(feedbackLabel)  // Add to the cell's content view
        
        feedbackLabel.numberOfLines = 0
        feedbackLabel.textAlignment = .center
        feedbackLabel.font = UIFont.systemFont(ofSize: 22)  // Set font size for better readability
        feedbackLabel.textColor = .white  // Set text color to white
        feedbackLabel.backgroundColor = .purple  // Set background color to purple
        
        // Setup constraints
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            feedbackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            feedbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            feedbackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func configureFeedback(isCorrect: Bool, correctAnswer: String) {
        feedbackLabel.isHidden = false  
        feedbackLabel.text = isCorrect ? "Correct!" : "Incorrect! The correct answer was \(correctAnswer)."
        feedbackLabel.textColor = isCorrect ? UIColor.green : UIColor.red
        layoutIfNeeded()  // Update layout if needed
    }

    
//    func configureFeedback(isCorrect: Bool, correctAnswer: String) {
//        feedbackLabel.isHidden = false
//        feedbackLabel.text = isCorrect ? "Correct!" : "Incorrect! The correct answer was \(correctAnswer)."
//        feedbackLabel.textColor = isCorrect ? .green : .red
//        layoutIfNeeded() 
//    }
}
