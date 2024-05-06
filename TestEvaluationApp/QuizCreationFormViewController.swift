//
//  QuizCreationFormViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/1/24.
//

/*
 Users can add questions along with options and correct answers through a form within the app. The data will be stored in a text file.
 Users can access a form to input quiz questions, options, and correct answers.
 ● Each question must have at least four options and one correct answer.
 ● Upon submission, the data will be stored in a text file.
 
 
 use collection view for the options for more flexiablelity
 
 
 view.endEditing(true) -> for last entry to be saved
 
 */

// UIStackView


import UIKit

class QuizCreationFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // format to save the entered questions, options, and the correct answer.
    var questions: [[String: Any]] = [
        [
            "question": "",
            "options": [],
            "answer": -1    // -1 -> no selected answer initially
        ]
    ]
    
    @IBOutlet weak var quizCreationTitleLabel: UILabel!
    @IBOutlet weak var quizCreationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizCreationTableView.delegate = self
        quizCreationTableView.dataSource = self
        quizCreationTableView.separatorColor = .clear
        quizCreationTitleLabel.text = "Quiz Questions Creation Form"
        
        quizCreationTableView.register(UINib(nibName: "SubmitQuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "SubmitQuestionCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // for users to enter questions, options, correct answer and save all these for disply on the next collection view for user to take the quiz
            return questions.count
        }
        else {
            return 1 // save button maybe, anything else need?
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { // swiched format
            let question = questions[indexPath.row]
            let options = question["options"] as? [String] ?? []
            return 180.0 + CGFloat(options.count * 40) // adjust the tableviewcell size according to how many options there are
        } 
        else if indexPath.section == 1 {
            return 150 // has 2 buttons
        }
        else {
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // questions, options(stackview) / answer (SegmentedControl)
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizQuestionCreationCell", for: indexPath) as! QuizQuestionCreationTableViewCell
            let questionInfo = questions[indexPath.row]
            cell.questionTextField.text = questionInfo["question"] as? String
            
            cell.clearOptions() // unsure maybe need to set it up for clear existing options
            
            cell.configureOptions(options: questionInfo["options"] as? [String] ?? [])
            
            cell.correctAnswerSegmentedControl.selectedSegmentIndex = questionInfo["answer"] as? Int ?? -1
            
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1{ // Submit Question button
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitQuestionCell", for: indexPath) as! SubmitQuestionTableViewCell
            cell.delegate = self
            cell.submitAction = { [weak self] in
                self?.saveQuestionsToFile()
            }
            
            return cell
        }
        else{ // Show Question List button
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShowQuestionListCell", for: indexPath) as! ShowQuestionListTableViewCell
            cell.showQuestionListAction = { [weak self] in
                self?.saveQuestionsToFile()
            }
            return cell
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? QuizQuestionCreationTableViewCell,
              let indexPath = quizCreationTableView.indexPath(for: cell) else {
            return
        }
        var question = questions[indexPath.row]
        if textField == cell.questionTextField {
            question["question"] = textField.text ?? ""
        } else if let optionIndex = cell.optionsStackView.arrangedSubviews.firstIndex(of: textField), var options = question["options"] as? [String] {
            options[optionIndex] = textField.text ?? ""
            question["options"] = options
        }
        questions[indexPath.row] = question
    }
    
    func addOption(toQuestionAtIndex index: Int, option: String) {
        guard index < questions.count else { return }
        var question = questions[index]
        var options = question["options"] as? [String] ?? []
        options.append(option)
        question["options"] = options
        questions[index] = question
    }
    
    func updateOption(forQuestionAtIndex questionIndex: Int, optionIndex: Int, newText: String) {
        guard questionIndex < questions.count else { return }
        var question = questions[questionIndex]
        var options = question["options"] as? [String] ?? []
        if optionIndex < options.count {
            options[optionIndex] = newText
            question["options"] = options
            questions[questionIndex] = question
        }
    }
    
    @objc func addQuestion() {
        let newQuestion = [
            "question": "",
            "options": [],
            "answer": -1    // -1 -> no selected answer initially
        ] as [String : Any]
        view.endEditing(true)
        questions.append(newQuestion)
        quizCreationTableView.insertRows(at: [IndexPath(row: questions.count - 1, section: 0)], with: .automatic)
        
    } // need to do tableView.reloadData()
    // need give flexibablity for how many options that they need, save table and refresh it, black it. reload the textfield. add it the page go down, add question, attemp quiz, history
    
    func saveQuestionsToFile() {
        view.endEditing(true)
        print("Final questions before saving: \(questions)")
        let filePath = getDocumentsDirectory().appendingPathComponent("quizQuestionsData.txt")
        do {
            let data = try JSONSerialization.data(withJSONObject: questions, options: .prettyPrinted)
            try data.write(to: filePath)
            print("Saved successfully to \(filePath)")
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func correctAnswerChanged(_ sender: UISegmentedControl) {
        guard let cell = sender.superview?.superview as? QuizQuestionCreationTableViewCell,
              let indexPath = quizCreationTableView.indexPath(for: cell) else {
            return
        }
        var question = questions[indexPath.row]
        question["answer"] = sender.selectedSegmentIndex //+ 1 // Store the selected index as the answer
        questions[indexPath.row] = question
    }
    
}

extension QuizCreationFormViewController: QuizQuestionCreationCellDelegate {
    
    func addOptionPressed(in cell: QuizQuestionCreationTableViewCell) {
        view.endEditing(true)
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else { return }
        let currentOptions = cell.optionsStackView.arrangedSubviews.compactMap { ($0 as? UITextField)?.text }
        print("Options before adding new one: \(String(describing: questions[indexPath.row]["options"]))")
            
        var question = questions[indexPath.row]
        question["options"] = currentOptions
        var options = (question["options"] as? [String]) ?? []
        options.append("New Option")
        question["options"] = options
        questions[indexPath.row] = question
        quizCreationTableView.reloadRows(at: [indexPath], with: .automatic)
//        view.endEditing(true)
    }
    
    func removeOptionPressed(in cell: QuizQuestionCreationTableViewCell) {
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else { return }
        var question = questions[indexPath.row]
        var options = (question["options"] as? [String]) ?? []
        if options.count > 2 {
            options.removeLast()
            question["options"] = options
            // Adjust answer index if necessary
            let answerIndex = (question["answer"] as? Int) ?? -1
            if answerIndex >= options.count {
                question["answer"] = options.count - 1  // Adjust answer to the last option
            }
            questions[indexPath.row] = question
            quizCreationTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int) {
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else {
            return
        }
        var question = questions[indexPath.row]
        question["answer"] = selectedAnswerIndex //+ 1
        questions[indexPath.row] = question
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, in cell: QuizQuestionCreationTableViewCell) {
        guard let cell = textField.superview?.superview as? QuizQuestionCreationTableViewCell,
              let indexPath = quizCreationTableView.indexPath(for: cell) else {
            return
        }
        let options = cell.optionsStackView.arrangedSubviews.compactMap { ($0 as? UITextField)?.text }
        var question = questions[indexPath.row]
        question["options"] = options
        question["question"] = cell.questionTextField.text ?? ""
        
        questions[indexPath.row] = question
        print("Updated model: \(questions)")
    }
    
    
}
