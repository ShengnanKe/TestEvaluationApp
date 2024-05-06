//
//  QuizHistoryViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//


/* past quiz attempts:
 Each attempt will show details such as the quiz name, date of attempt, score, and a list of questions attempted along with their correctness.
*/


import UIKit

class QuizHistoryViewController: UIViewController {
    
    @IBOutlet weak var quizHistoryTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizHistoryTitleLabel.text = "Quiz Attempt History"

    }
    

}
