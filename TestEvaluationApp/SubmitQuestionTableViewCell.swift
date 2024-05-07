//
//  SubmitQuestionTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

protocol SubmitQuestionTableViewCellDelegate: AnyObject {
    func addNewQuestion()
    func submitQuestion()
}

class SubmitQuestionTableViewCell: UITableViewCell {
    
    weak var delegate: SubmitQuestionTableViewCellDelegate?
    
    @IBOutlet weak var submitQuestionButton: UIButton!
    @IBOutlet weak var addNewQuestionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("SubmitQuestionTableViewCell loaded")
        submitQuestionButton.setTitle("Submit Question", for: .normal)
        addNewQuestionButton.setTitle("Add New Question", for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var submitAction: (() -> Void)?
    
    @IBAction func submitQuestionButtonTapped(_ sender: UIButton) {
        delegate?.submitQuestion()
    }
    
    @IBAction func addNewQuestionPressed(_ sender: UIButton) {
        delegate?.addNewQuestion()
    }
    
}

extension QuizCreationFormViewController: SubmitQuestionTableViewCellDelegate {
    func addNewQuestion() {
        let newQuestion = ["question": "", "options": [], "answer": -1] as [String: Any]
        questions.append(newQuestion)
        quizCreationTableView.reloadData()
        let indexPath = IndexPath(row: questions.count - 1, section: 0)
        quizCreationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func submitQuestion() {
        saveQuestionsToFile()
    }
    
}

