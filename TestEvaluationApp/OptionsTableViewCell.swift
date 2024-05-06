//
//  OptionsTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    var optionButtons: [UIButton] = []
    var onOptionSelected: ((Int) -> Void)?
    
    func setupOptions(options: [String], questionIndex: Int, onOptionSelected: @escaping (Int) -> Void) {
        self.onOptionSelected = onOptionSelected
        
        // Remove old option buttons
        optionButtons.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
        
        var lastButton: UIButton? = nil
        
        for (index, option) in options.enumerated() { //  button for each option
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.tag = index  // Tag for answer check
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            self.contentView.addSubview(button)  // Add button to contentView
            optionButtons.append(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: lastButton?.bottomAnchor ?? contentView.topAnchor, constant: 20),
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            lastButton = button
        }
        layoutIfNeeded()
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        print("Option selected: \(sender.tag), Button frame: \(sender.frame)")
        onOptionSelected?(sender.tag)
    }
}
