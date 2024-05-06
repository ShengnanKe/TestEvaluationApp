//
//  OptionsTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    var optionButtons: [UIButton] = []
    var onOptionSelected: ((Int, Int) -> Void)? // Updated to pass questionIndex too
    
    func setupOptions(options: [String], questionIndex: Int, onOptionSelected: @escaping (Int, Int) -> Void) {
        self.onOptionSelected = onOptionSelected
        
        //to avoid the overlap, it was showing options from pervious questions
        optionButtons.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
        
        for (index, option) in options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            contentView.addSubview(button)
            setupButtonConstraints(button, index: index)
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        onOptionSelected?(sender.tag, self.tag)
    }
    
    private func setupButtonConstraints(_ button: UIButton, index: Int) {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: index == 0 ? contentView.topAnchor : optionButtons[index - 1].bottomAnchor, constant: index == 0 ? 40 : 20), 
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        optionButtons.append(button)
    }
}


//
//
//class OptionsTableViewCell: UITableViewCell {
//    var optionButtons: [UIButton] = []
//    var onOptionSelected: ((Int) -> Void)?
//
//    func setupOptions(options: [String], questionIndex: Int, onOptionSelected: @escaping (Int) -> Void) {
//        self.onOptionSelected = onOptionSelected
//
//        optionButtons.forEach { $0.removeFromSuperview() }
//        optionButtons.removeAll()
//
//        // new buttons for each option
//        for (index, option) in options.enumerated() {
//            let button = UIButton(type: .system)
//            button.setTitle(option, for: .normal)
//            button.tag = index
//            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
//            contentView.addSubview(button)
//            optionButtons.append(button)
//
//            button.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                button.topAnchor.constraint(equalTo: index == 0 ? contentView.topAnchor : optionButtons[index - 1].bottomAnchor, constant: index == 0 ? 40 : 20),  // Increased top margin for the first button
//                button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//                button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//                button.heightAnchor.constraint(equalToConstant: 50)
//            ])
//        }
//
//        layoutIfNeeded()
//    }
//
//    @objc private func optionSelected(_ sender: UIButton) {
//        onOptionSelected?(sender.tag)
//    }
//}
