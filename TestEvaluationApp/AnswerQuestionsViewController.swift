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
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        switch indexPath.row {
    //        case 1: // for Options
    //            return CGFloat(60 * selectedQuestions[currentQuestionIndex]["options"].count + 20)
    //        default:
    //            return UITableView.automaticDimension
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let questionData = selectedQuestions[currentQuestionIndex]
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionTableViewCell
            cell.questionLabel.text = questionData["question"] as? String ?? "No question available"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsTableViewCell
            if let options = questionData["options"] as? [String] {
                cell.setupOptions(options: options, questionIndex: currentQuestionIndex) { selectedAnswer in
                    self.checkAnswer(selectedAnswer: selectedAnswer)
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackTableViewCell
            cell.feedbackLabel.isHidden = true
            return cell
        default:
            fatalError("Unexpected indexPath")
        }
    }
    
    func checkAnswer(selectedAnswer: Int) {
        print("Checking answer: \(selectedAnswer)")
        guard currentQuestionIndex < selectedQuestions.count else { return }
        let correctAnswer = selectedQuestions[currentQuestionIndex]["answer"] as? Int ?? -1
        let isCorrect = selectedAnswer == correctAnswer
        correctAnswers += isCorrect ? 1 : 0
        
        if let feedbackCell = quizAttemptTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FeedbackTableViewCell {
            let correctOption = selectedQuestions[currentQuestionIndex]["options"] as? [String] ?? []
            let correctAnswerText = (correctAnswer >= 0 && correctAnswer < correctOption.count) ? correctOption[correctAnswer] : "N/A"
            feedbackCell.configureFeedback(isCorrect: isCorrect, correctAnswer: correctAnswerText)
        }
        
//        if let feedbackCell = quizAttemptTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FeedbackTableViewCell {
//            feedbackCell.feedbackLabel.isHidden = false
//            
//            if let options = selectedQuestions[currentQuestionIndex]["options"] as? [String], correctAnswer >= 0, correctAnswer < options.count {
//                feedbackCell.feedbackLabel.text = isCorrect ? "Correct!" : "Incorrect! Correct answer: \(options[correctAnswer])"
//            } else {
//                feedbackCell.feedbackLabel.text = "Error retrieving correct answer."
//            }
//            
//            feedbackCell.feedbackLabel.textColor = isCorrect ? UIColor.green : UIColor.red
//        }
        
        // Proceed to the next question after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.nextQuestion()
        }
    }
    
    
    
    //    func checkAnswer(selectedAnswer: Int) {
    //        let correctAnswer = selectedQuestions[currentQuestionIndex]["answer"] as? Int ?? -1
    //        let correctOption = (selectedQuestions[currentQuestionIndex]["options"] as? [String])?[correctAnswer]
    //
    //        if let feedbackCell = quizAttemptTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FeedbackTableViewCell {
    //            feedbackCell.feedbackLabel.isHidden = false
    //
    //            if selectedAnswer == correctAnswer {
    //                correctAnswers += 1
    //                feedbackCell.feedbackLabel.text = "Correct!"
    //                feedbackCell.feedbackLabel.textColor = UIColor.green
    //            } else {
    //                feedbackCell.feedbackLabel.text = "Incorrect! The correct answer was '\(correctOption ?? "N/A")'."
    //                feedbackCell.feedbackLabel.textColor = UIColor.red
    //            }
    //        }
    //
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    //            self.nextQuestion()
    //        }
    //    }
    
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
        
        let resultData = [
            "username": username ?? "Anonymous",
            "date": dateString,
            "score": "\(correctAnswers)/\(selectedQuestions.count)",
            "questions": selectedQuestions.map { $0["question"] as? String ?? "Unknown Question" },
            "answers": selectedQuestions.map { $0["selectedAnswer"] as? Int ?? -1 }
        ] as [String : Any]
        
        do {
            let dataToSave = try JSONSerialization.data(withJSONObject: resultData, options: .prettyPrinted)
            if FileManager.default.fileExists(atPath: filePath.path) {
                // If the file exists, append new data
                if let fileHandle = FileHandle(forWritingAtPath: filePath.path) {
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(dataToSave)
                    fileHandle.closeFile()
                }
            } else {
                // If the file does not exist, create it and write data
                try dataToSave.write(to: filePath, options: .atomic)
            }
            print("Saved successfully to \(filePath)")
        } catch {
            print("Failed to save results: \(error)")
        }
    }
    
    func finishQuiz() {
        print("Quiz Completed. Score: \(correctAnswers)/\(selectedQuestions.count)")
        saveResults()
    
        navigationController?.popViewController(animated: true) // go back to QuizAttemptViewController, another user and do the quiz
    }
    
    func verifySavedResults() {
        let filePath = getDocumentsDirectory().appendingPathComponent("quizResultsData.txt")
        do {
            let data = try Data(contentsOf: filePath)
            let savedResults = try JSONSerialization.jsonObject(with: data, options: [])
            print("Saved Results: \(savedResults)")
        } catch {
            print("Failed to read saved results: \(error)")
        }
    }
}

