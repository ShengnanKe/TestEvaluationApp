//
//  AnswerQuestionsViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class AnswerQuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var username: String?
    var questions: [[String: Any]] = []
    var selectedQuestions: [[String: Any]] = []
    var currentQuestionIndex = 0
    var correctAnswers = 0
    
    @IBOutlet weak var quizAttemptTableView: UITableView!
    //var AnswerQuestionTableView: UITableView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizAttemptTableView.delegate = self
        quizAttemptTableView.dataSource = self
        quizAttemptTableView.separatorColor = .clear
        
        quizAttemptTableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        quizAttemptTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsCell")
        quizAttemptTableView.register(FeedbackTableViewCell.self, forCellReuseIdentifier: "FeedbackCell")
        
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
                
                // at least 5 questions
                guard questions.count >= 5 else { return }
                selectedQuestions = Array(questions.shuffled().prefix(5))
                DispatchQueue.main.async {
                    self.quizAttemptTableView.reloadData()
                }
            }
        } catch {
            print("Failed to load questions: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // One for the question, one for the options, one for feedback
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section < selectedQuestions.count else {
            fatalError("Section index \(indexPath.section) out of range")
        }
        
        let questionData = selectedQuestions[indexPath.section]
        switch indexPath.row {
        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionTableViewCell else {
//                fatalError("Unable to dequeue QuestionTableViewCell")
//            }
//            if let questionText = selectedQuestions[indexPath.section]["question"] as? String {
//                cell.questionLabel.text = questionText
//            } else {
//                fatalError("Question text not found in data")
//            }
//            return cell
//            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
            let questionData = questions[indexPath.row]  // Adjust according to your data structure
            cell.questionLabel.text = questionData["question"] as? String ?? "No question available"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsTableViewCell
            let options = questions[indexPath.section]["options"] as? [String] ?? []
            cell.setupOptions(options: options, questionIndex: currentQuestionIndex) { selectedAnswer in
                self.checkAnswer(selectedAnswer: selectedAnswer)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackTableViewCell
            // Initially hide feedback
            cell.feedbackLabel.isHidden = true
            return cell
        default:
            fatalError("Unexpected indexPath")
        }
    }
    
    func checkAnswer(selectedAnswer: Int) {
        let correctAnswer = selectedQuestions[currentQuestionIndex]["answer"] as? Int ?? -1
        if let feedbackCell = quizAttemptTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FeedbackTableViewCell {
            feedbackCell.feedbackLabel.isHidden = false
            if selectedAnswer == correctAnswer {
                correctAnswers += 1
                feedbackCell.configureFeedback(isCorrect: true, correctAnswer: "")
            } else {
                if let correctOption = selectedQuestions[currentQuestionIndex]["options"] as? [String], correctAnswer >= 0 && correctAnswer < correctOption.count {
                    feedbackCell.configureFeedback(isCorrect: false, correctAnswer: correctOption[correctAnswer])
                }
            }
        }
        // Move to next question or finish quiz
        nextQuestion()
    }
    
    func nextQuestion() {
        if currentQuestionIndex < selectedQuestions.count - 1 {
            currentQuestionIndex += 1
            quizAttemptTableView.reloadData()
        } else {
            finishQuiz()
        }
    }
    
    func saveResults() {
        let filePath = getDocumentsDirectory().appendingPathComponent("quizResultsData.txt")
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let dateString = dateFormatter.string(from: Date())
        
        let resultString = "Username: \(username ?? "Anonymous"), Score: \(correctAnswers)/\(selectedQuestions.count), Date: \(dateString)\n"
        
        do {
            // Check if file exists
            if FileManager.default.fileExists(atPath: filePath.path) {
                // If file exists, append the new results
                if let fileHandle = try? FileHandle(forWritingTo: filePath) {
                    fileHandle.seekToEndOfFile()
                    if let data = resultString.data(using: .utf8) {
                        fileHandle.write(data)
                    }
                    fileHandle.closeFile()
                }
            } else {
                // If file does not exist, create it and write data
                try resultString.write(to: filePath, atomically: true, encoding: .utf8)
            }
        } catch {
            print("Failed to write results: \(error)")
        }
    }

    func finishQuiz() {
        print("Quiz Completed. Score: \(correctAnswers)/\(selectedQuestions.count)")
        saveResults()
        // Here you might want to navigate to a results summary page or return to the main menu
    }

    
    
    
}
