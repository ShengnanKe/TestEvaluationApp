//
//  QuizQuestionCreationTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/2/24.
//

import UIKit

protocol QuizQuestionCreationCellDelegate: AnyObject { //declare delegate
    func correctAnswerChanged(_ cell: QuizQuestionCreationTableViewCell, selectedAnswerIndex: Int)
    func textFieldDidEndEditing(_ textField: UITextField, in cell: QuizQuestionCreationTableViewCell)
    func addOptionPressed(in cell: QuizQuestionCreationTableViewCell)
    func removeOptionPressed(in cell: QuizQuestionCreationTableViewCell)
}

class QuizQuestionCreationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var optionsStackView: UIStackView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var correctAnswerSegmentedControl: UISegmentedControl!
    
    weak var delegate: QuizQuestionCreationCellDelegate?
    var textChanged: ((String) -> Void)? // for saving data
    var questionIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionTextField.placeholder = "Enter question here: "
        addButton.setTitle("Add Option", for: .normal)
        removeButton.setTitle("Remove Option", for: .normal)
        
        questionTextField.delegate = self
        setupInitialOptions()
        correctAnswerSegmentedControl.addTarget(self, action: #selector(correctAnswerChanged(_:)), for: .valueChanged)
    }
    
    func configureOptionTextField(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        //textField.tag = index
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        guard let delegate = delegate as? QuizCreationFormViewController, let text = textField.text else { return }
        delegate.updateOption(forQuestionAtIndex: questionIndex, optionIndex: textField.tag, newText: text)
        print("hahaha")
    }
    
    @IBAction func addOptionPressed(_ sender: UIButton) {
        delegate?.addOptionPressed(in: self)
    }
    
    @IBAction func removeOptionPressed(_ sender: UIButton) {
        delegate?.removeOptionPressed(in: self)
    }
    
    func setupInitialOptions() { // is this necessary? check
        for index in 0..<2 {
            addOptionField(withText: "Option \(index)")
        }
    }
    
    func clearOptions() {
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        correctAnswerSegmentedControl.removeAllSegments()
    }
    
    func configureOptions(options: [String]) {
        clearOptions()
        for option in options {
            addOptionField(withText: option)
        }
    }
    
    func configure(with questionInfo: [String: Any]) {
        questionTextField.text = questionInfo["question"] as? String
        if let options = questionInfo["options"] as? [String] {
            configureOptions(options: options)
        }
        let answerIndex = questionInfo["answer"] as? Int ?? -1
        correctAnswerSegmentedControl.selectedSegmentIndex = answerIndex
    }
    
    func addOptionField(withText text: String = "New Option") {
        let optionTextField = UITextField()
        optionTextField.placeholder = "Enter option here"
        optionTextField.borderStyle = .roundedRect
        optionTextField.text = text
        optionTextField.delegate = self
        configureOptionTextField(optionTextField)
        
        optionsStackView.addArrangedSubview(optionTextField)
        
        correctAnswerSegmentedControl.insertSegment(withTitle: String(optionsStackView.arrangedSubviews.count), at: optionsStackView.arrangedSubviews.count - 1, animated: true)
        correctAnswerSegmentedControl.selectedSegmentIndex = 0  // Default to the first option as correct
    }
    
    func removeOptionField() {
        if optionsStackView.arrangedSubviews.count > 2 { // minimum of two options
            if let lastView = optionsStackView.arrangedSubviews.last {
                optionsStackView.removeArrangedSubview(lastView)
                lastView.removeFromSuperview()
                correctAnswerSegmentedControl.removeSegment(at: optionsStackView.arrangedSubviews.count, animated: true)
            }
        }
    }
    
    @objc func correctAnswerChanged(_ sender: UISegmentedControl) {
        delegate?.correctAnswerChanged(self, selectedAnswerIndex: sender.selectedSegmentIndex)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionTextField.text = nil
        clearOptions()
        correctAnswerSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(textField, in: self)
    }
    
    
}

