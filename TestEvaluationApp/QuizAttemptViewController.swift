//
//  QuizAttemptViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

/*
 Before starting the quiz, users must enter their username.
 ● Each question will be presented one at a time with multiple-choice options.
 ● Upon selecting an option, immediate feedback will be provided.
 ● Users can proceed to the next question after receiving feedback.
 ● After completing the quiz, users will receive their score and be redirected to the
 main menu.
 
 */

import UIKit

class QuizAttemptViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    var questions = [[String: Any]]()
    var selectedQuestions: [[String: Any]] = []
    
    @IBOutlet weak var quizAttemptTitleLabel: UILabel!
    @IBOutlet weak var quizAttemptTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizAttemptTitleLabel.text = "Quiz Attempt"
        
        quizAttemptTableView.delegate = self
        quizAttemptTableView.dataSource = self
        quizAttemptTableView.separatorColor = .clear
        
        loadQuizData()
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func loadQuizData() {
        let filePath = getDocumentsDirectory().appendingPathComponent("quizQuestionsData.txt")
        do {
            let data = try Data(contentsOf: filePath)
            if let loadedQuestions = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
        
                self.questions = loadedQuestions
                
                // Randomly select 5 questions if there are more than 5
                guard questions.count >= 5 else { return }
                selectedQuestions = Array(questions.shuffled().prefix(5))
                DispatchQueue.main.async {
                    self.quizAttemptTableView.reloadData()
                }
            }
        } catch {
            print("Error reading or parsing quiz data: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return 
    }
    
   
}
