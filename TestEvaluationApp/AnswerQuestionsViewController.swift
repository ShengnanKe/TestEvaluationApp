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
        
        quizAttemptTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsCell") // i didn't set up this cell on storyboard -> by programming
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 120
        case 1:
            if let options = selectedQuestions[currentQuestionIndex]["options"] as? [String] {
                let optionsCount = options.count
                return CGFloat(50 * optionsCount + 40 + 20 * (optionsCount - 1)) // adjust based on the number of options
            }
            return 120
        case 2:
            return 60 // Feedback cell
        default:
            return UITableView.automaticDimension
        }
    }
    
    func checkAnswer(selectedAnswer: Int) {
        print("Checking answer: \(selectedAnswer)")
        guard currentQuestionIndex < selectedQuestions.count else { return }
        let correctAnswer = selectedQuestions[currentQuestionIndex]["answer"] as? Int ?? -1
        let isCorrect = selectedAnswer == correctAnswer
        correctAnswers += isCorrect ? 1 : 0
        
        selectedQuestions[currentQuestionIndex]["selectedAnswer"] = selectedAnswer
        
        if let feedbackCell = quizAttemptTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? FeedbackTableViewCell {
            let correctOption = selectedQuestions[currentQuestionIndex]["options"] as? [String] ?? []
            let correctAnswerText = (correctAnswer >= 0 && correctAnswer < correctOption.count) ? correctOption[correctAnswer] : "N/A"
            feedbackCell.configureFeedback(isCorrect: isCorrect, correctAnswer: correctAnswerText)
            feedbackCell.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.nextQuestion()
        }
    }
    
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
                cell.setupOptions(options: options, questionIndex: currentQuestionIndex) { selectedAnswer, questionIndex in
                    // Directly update the selected answer in the selectedQuestions array
                    self.selectedQuestions[questionIndex]["selectedAnswer"] = selectedAnswer
                    self.checkAnswer(selectedAnswer: selectedAnswer)
                }
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell", for: indexPath) as! FeedbackTableViewCell
            cell.feedbackLabel.isHidden = true // Initially hide the feedback
            return cell
        default:
            fatalError("???")
        }
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
        
        let newResultData = [
            "username": username ?? "Anonymous",
            "date": dateString,
            "score": "\(correctAnswers)/\(selectedQuestions.count)",
            "questions": selectedQuestions.map { $0["question"] as? String ?? "Unknown Question" },
            "answers": selectedQuestions.map { $0["selectedAnswer"] as? Int ?? -1 }
        ] as [String: Any]
        
        do {
            var allResults = [[String: Any]]()
            if FileManager.default.fileExists(atPath: filePath.path) {
                // Read existing data
                let data = try Data(contentsOf: filePath)
                if let existingResults = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    allResults = existingResults // Load existing data
                }
            }
            
            allResults.append(newResultData)
            let dataToSave = try JSONSerialization.data(withJSONObject: allResults, options: .prettyPrinted)
            try dataToSave.write(to: filePath, options: .atomic)
            print("Saved successfully in \(filePath)")
        } catch {
            print("Failed to save results - \(error)")
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
            print("Saved Results - \(savedResults)")
        } catch {
            print("Failed to read saved results -\(error)")
        }
    }
}

