//
//  QuizAttemptViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class QuizAttemptViewController: UIViewController {
    
    var questions: [[String: Any]] = []
    var selectedQuestions: [[String: Any]] = []
    
    @IBOutlet weak var quizAttemptLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var startQuizButton: UIButton! // start taking quiz and keep record of the username
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizAttemptLabel.text = "Quiz Attempt"
        
        usernameTextField.placeholder = "Please enter your username here: "
        
        startQuizButton.setTitle("Start Quiz", for: .normal) // navigate to the AnswerQuestionsViewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnswerQuestions", let destinationVC = segue.destination as? AnswerQuestionsViewController {
            destinationVC.username = usernameTextField.text
            destinationVC.questions = selectedQuestions
        }
    }
}
