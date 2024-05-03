//
//  QuestionListViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/3/24.
//  QLVC
//

import UIKit

class QuestionListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var questions: [[String: Any]] = []
    
    var collectionView: UICollectionView!
    
    @IBOutlet weak var QuestionListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Question List"
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 100)  // Set cell size
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(QuestionCollectionViewCell.self, forCellWithReuseIdentifier: "QuestionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as! QuestionCollectionViewCell
        if let question = questions[indexPath.row]["question"] as? String {
            cell.setup(questionText: question)
        }
        return cell
    }
}

