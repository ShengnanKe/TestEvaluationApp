//
//  HistoryAttemptTableViewCell.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/6/24.
//

import UIKit

class HistoryAttemptTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // check
        //print("History load good")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Function to configure cell with data
    func configure(with data: [String: Any]) {
        usernameLabel.text = data["username"] as? String ?? "Anonymous"
        scoreLabel.text = "Score: \(data["score"] as? String ?? "N/A")"
        dateLabel.text = data["date"] as? String ?? "No Date"
    }
}
