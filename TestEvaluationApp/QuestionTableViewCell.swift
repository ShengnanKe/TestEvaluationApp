//
//  QuestionTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//

//@IBOutlet weak var questionLabel: UILabel!
import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    var questionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupQuestionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupQuestionLabel() {
        questionLabel = UILabel()
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .left
        questionLabel.font = UIFont.systemFont(ofSize: 22)
        questionLabel.backgroundColor = .purple
        questionLabel.textColor = .white
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            questionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
