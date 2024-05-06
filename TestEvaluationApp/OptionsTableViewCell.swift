//
//  OptionsTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    var optionButtons: [UIButton] = []
    var onOptionSelected: ((Int) -> Void)?  // Store the closure
    
    func setupOptions(options: [String], questionIndex: Int, onOptionSelected: @escaping (Int) -> Void) {
        self.onOptionSelected = onOptionSelected  // Store the passed closure

        // Remove old option buttons if any
        optionButtons.forEach { $0.removeFromSuperview() }
        optionButtons.removeAll()
        
        // Create a button for each option
        for (index, option) in options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.tag = index  // Tag button with its index to identify it later
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            addSubview(button)
            optionButtons.append(button)
            
            // Setup constraints here or use a layout method
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(44 * index)),
                button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                button.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        onOptionSelected?(sender.tag)  // Use the stored closure
    }
}
