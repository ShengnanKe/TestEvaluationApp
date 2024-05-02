//
//  QuizCreationFormViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/1/24.
//

/*
 Users can add questions along with options and correct answers through a form within the app. The data will be stored in a text file.
 Users can access a form to input quiz questions, options, and correct answers.
 ● Each question must have at least two options and one correct answer.
 ● Upon submission, the data will be stored in a text file.
 
*/

import UIKit

class QuizCreationFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // form to enter questions, options, and the correct answer.
    
    @IBOutlet weak var QuizCreationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuizCreationTableView.delegate = self
        QuizCreationTableView.dataSource = self
        QuizCreationTableView.separatorColor = .clear
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 { //
            return 5
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100.0 // the button to navegate to page
        } else if indexPath.section == 1{
            return 200.0 // the textfield takes more space -> swiched format
        }else {
            return 100.0 // The height for all other cells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizQuestionCell", for: indexPath) as! QuizQuestionTableViewCell
            if indexPath.row == 0 {
                cell.questionLabel.text = "Question 1: "
                cell.choiceOneButton.setTitle("Answer 1:", for: .normal)
                cell.choiceTwoButton.setTitle("Answer 2:", for: .normal)
            } else if {
                cell.questionLabel.text = "Question 2: "
                cell.choiceOneButton.setTitle("Answer 1:", for: .normal)
                cell.choiceTwoButton.setTitle("Answer 2:", for: .normal)
            } else{
                cell.questionLabel.text = "Question 2: "
                cell.choiceOneButton.setTitle("Answer 1:", for: .normal)
                cell.choiceTwoButton.setTitle("Answer 2:", for: .normal)
            }
            
        }
    }
    // var question: String
//    var options: [String]
//    var correctAnswer: Int
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
