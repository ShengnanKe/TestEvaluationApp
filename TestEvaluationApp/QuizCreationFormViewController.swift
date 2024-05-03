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

import UIKit

class QuizCreationFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // form to enter questions, options, and the correct answer.
    var questions: [[String: Any]] = [
        [
            "question" : "",
            "options" : ["", "", "", ""],
            "answer" : 0
        ]
    ]
    
    @IBOutlet weak var quizCreationTitleLabel: UILabel!
    @IBOutlet weak var quizCreationTableView: UITableView!
    
    //quizCreationTitleLabel.text = "Enter your Questions and Answers" // a label for filling the quiz question maybe
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizCreationTableView.delegate = self
        quizCreationTableView.dataSource = self
        quizCreationTableView.separatorColor = .clear
        
        quizCreationTitleLabel.text = "Quiz Questions Creation Form"
        
        // Do any additional setup after loading the view.
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
        if indexPath.section == 0 { // the textfield takes more space -> swiched format
            return 320.0
        } else {
            return 100.0 // the button to navegate to page & The height for all other cells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { // questions, options(textfield) / answer (SegmentedControl)
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizQuestionCreationCell", for: indexPath) as! QuizQuestionCreationTableViewCell
            let questionInfo = questions[indexPath.row]
            cell.questionTextField.text = questionInfo["question"] as? String
            let options = questionInfo["options"] as? [String] ?? ["", "", "", ""]
            cell.choice1TextField.text = options[0]
            cell.choice2TextField.text = options[1]
            cell.choice3TextField.text = options[2]
            cell.choice4TextField.text = options[3]
            cell.correctAnswerSegmentedControl.selectedSegmentIndex = questionInfo["answer"] as? Int ?? -1
            
            cell.questionTextField.delegate = self
            cell.choice1TextField.delegate = self
            cell.choice2TextField.delegate = self
            cell.choice3TextField.delegate = self
            cell.choice4TextField.delegate = self
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1{ // Submit Question
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitQuizCell", for: indexPath) as! SubmitQuizTableViewCell
            cell.submitAction = { [weak self] in
                self?.saveQuestionsToFile()
            }
            return cell
        }
        else{ // Show Question List
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
        
        if textField == cell.questionTextField {
            questions[indexPath.row]["question"] = textField.text ?? ""
        } else if textField == cell.choice1TextField {
            updateOption(forRow: indexPath.row, optionIndex: 0, text: textField.text)
        } else if textField == cell.choice2TextField {
            updateOption(forRow: indexPath.row, optionIndex: 1, text: textField.text)
        } else if textField == cell.choice3TextField {
            updateOption(forRow: indexPath.row, optionIndex: 2, text: textField.text)
        } else if textField == cell.choice4TextField {
            updateOption(forRow: indexPath.row, optionIndex: 3, text: textField.text)
        }
    }
    
    func updateOption(forRow row: Int, optionIndex index: Int, text: String?) {
        var options = questions[row]["options"] as? [String] ?? ["", "", "", ""]
        options[index] = text ?? ""
        questions[row]["options"] = options
        print("Updated options for question \(row): \(options)") // Debugging line
    }
    
    func saveQuestionsToFile() {
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
    
}

extension QuizCreationFormViewController: QuizQuestionCreationCellDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, in cell: QuizQuestionCreationTableViewCell) {
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else { return }
        
        // Check which textField is being edited and update the data model accordingly
        switch textField {
        case cell.questionTextField:
            questions[indexPath.row]["question"] = textField.text // ?? ""
        case cell.choice1TextField:
            updateOption(forRow: indexPath.row, optionIndex: 0, text: textField.text)
        case cell.choice2TextField:
            updateOption(forRow: indexPath.row, optionIndex: 1, text: textField.text)
        case cell.choice3TextField:
            updateOption(forRow: indexPath.row, optionIndex: 2, text: textField.text)
        case cell.choice4TextField:
            updateOption(forRow: indexPath.row, optionIndex: 3, text: textField.text)
        default:
            break
        }
    }
    
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int) {
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else { return }
        
        questions[indexPath.row]["answer"] = selectedAnswerIndex
    }
    
    func navigateToQuestionList() {
        let questionListVC = QuestionListViewController()
        questionListVC.questions = self.questions  // Pass questions to QLVC
        self.navigationController?.pushViewController(questionListVC, animated: true)
    }
    
}
