//
//  QuizDetailViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/6/24.
//

import UIKit

class QuizDetailViewController: UIViewController {
    
    var quizDetails: [String: Any]?
    
    @IBOutlet weak var quizDetailPageLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!  // Assuming you're using a UITextView to display questions and answers

    override func viewDidLoad() {
        super.viewDidLoad()
        quizDetailPageLabel.text = "Quiz Detail Page"
        displayQuizDetails()
    }
    
    func displayQuizDetails() {
        if let details = quizDetails {
            usernameLabel.text = "User: \(details["username"] as? String ?? "Unknown")"
            scoreLabel.text = "Score: \(details["score"] as? String ?? "N/A")"
            dateLabel.text = "Date: \(details["date"] as? String ?? "Unknown Date")"
            
            var detailText = "Questions and Answers:\n\n"
            if let questions = details["questions"] as? [String], let answers = details["answers"] as? [Int] {
                for (index, question) in questions.enumerated() {
                    let answer = answers.count > index ? "Answer: \(answers[index])" : "Answer: N/A"
                    detailText += "\(index + 1). \(question)\n\(answer)\n\n"
                }
            }
            detailTextView.text = detailText
        }
    }
}
