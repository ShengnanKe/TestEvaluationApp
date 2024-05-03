//
//  QuestionCollectionViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/3/24.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    private var questionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        questionLabel = UILabel(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: self.frame.height - 10))
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .left
        questionLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(questionLabel)
        self.contentView.backgroundColor = UIColor.lightGray
        self.contentView.layer.cornerRadius = 8
    }
    
    func setup(questionText: String) {
        questionLabel.text = questionText
    }
    
}
