//
//  FeedbackTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {
    let feedbackLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFeedbackLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFeedbackLabel() {
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(feedbackLabel)
        feedbackLabel.numberOfLines = 0
        feedbackLabel.textAlignment = .center
        feedbackLabel.font = UIFont.systemFont(ofSize: 16)  // Set font size for better readability
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            feedbackLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            feedbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            feedbackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    func configureFeedback(isCorrect: Bool, correctAnswer: String) {
        if isCorrect {
            feedbackLabel.text = "Correct!"
            feedbackLabel.textColor = .green
        } else {
            feedbackLabel.text = "Incorrect! The correct answer was \(correctAnswer)."
            feedbackLabel.textColor = .red  // Set text color to red for incorrect answers
        }
    }
}
