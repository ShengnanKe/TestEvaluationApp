//
//  QuizQuestionCreationTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/2/24.
//

import UIKit

protocol QuizQuestionCreationCellDelegate: AnyObject {
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int)
}

class QuizQuestionCreationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var choice1TextField: UITextField!
    @IBOutlet weak var choice2TextField: UITextField!
    @IBOutlet weak var choice3TextField: UITextField!
    @IBOutlet weak var choice4TextField: UITextField!
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    weak var delegate: QuizQuestionCreationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        questionTextField.delegate = self
        choice1TextField.delegate = self
        choice2TextField.delegate = self
        choice3TextField.delegate = self
        choice4TextField.delegate = self
        
        questionTextField.placeholder = "Enter question here: "
        choice1TextField.placeholder = "Enter choice 1 here: "
        choice2TextField.placeholder = "Enter choice 2 here: "
        choice3TextField.placeholder = "Enter choice 3 here: "
        choice4TextField.placeholder = "Enter choice 4 here: "
        correctAnswerSegmentedControl.removeAllSegments()
        for i in 0..<4 { // Assuming 4 choices
            correctAnswerSegmentedControl.insertSegment(withTitle: String(i+1), at: i, animated: false)
        }
        correctAnswerSegmentedControl.addTarget(self, action: #selector(correctAnswerChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func correctAnswerChanged(_ sender: UISegmentedControl) {
        // Call the delegate method when a segment is selected
        delegate?.correctAnswerChanged(self, selectedAnswerIndex: sender.selectedSegmentIndex)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
