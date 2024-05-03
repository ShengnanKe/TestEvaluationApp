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
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizQuestionCreationCell", for: indexPath) as! QuizQuestionCreationTableViewCell
            let questionsData = questions[indexPath.row]
            cell.questionTextField.text = questionsData["question"] as? String ?? ""
            cell.choice1TextField.text = (questionsData["options"] as? [String])?[0] ?? ""
            cell.choice2TextField.text = (questionsData["options"] as? [String])?[1] ?? ""
            cell.choice3TextField.text = (questionsData["options"] as? [String])?[0] ?? ""
            cell.choice4TextField.text = (questionsData["options"] as? [String])?[1] ?? ""
            let answerIndex = questionsData["answer"] as? Int ?? 0
            cell.correctAnswerSegmentedControl.selectedSegmentIndex = answerIndex
            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitQuizCell", for: indexPath) as! SubmitQuizTableViewCell
            cell.submitAction = { [weak self] in
                self?.saveQuestionsToFile()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            saveQuestionsToFile()
        }
    }
    
    func saveQuestionsToFile() {
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension QuizCreationFormViewController: QuizQuestionCreationCellDelegate {
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int) {
        guard let indexPath = quizCreationTableView.indexPath(for: cell) else { return }
        
        questions[indexPath.row]["answer"] = selectedAnswerIndex
    }
}
