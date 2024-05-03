//
//  QuizQuestionCreationTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/2/24.
//

import UIKit

protocol QuizQuestionCreationCellDelegate: AnyObject {
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int)
    func textFieldDidEndEditing(_ textField: UITextField, in cell: QuizQuestionCreationTableViewCell)
}


class QuizQuestionCreationTableViewCell: UITableViewCell {
    
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
        questionTextField.placeholder = "Enter question here: "
        choice1TextField.placeholder = "Enter choice 1 here: "
        choice2TextField.placeholder = "Enter choice 2 here: "
        choice3TextField.placeholder = "Enter choice 3 here: "
        choice4TextField.placeholder = "Enter choice 4 here: "
        correctAnswerSegmentedControl.removeAllSegments()
        for i in 0..<4 { 
            correctAnswerSegmentedControl.insertSegment(withTitle: String(i+1), at: i, animated: false)
        }
        correctAnswerSegmentedControl.addTarget(self, action: #selector(correctAnswerChanged(_:)), for: .valueChanged)
        
    }
    
    @objc func correctAnswerChanged(_ sender: UISegmentedControl) {
        // Call the delegate method when a segment is selected
        delegate?.correctAnswerChanged(self, selectedAnswerIndex: sender.selectedSegmentIndex)
    }
    
}
