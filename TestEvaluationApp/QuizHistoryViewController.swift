//
//  QuizHistoryViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 5/5/24.
//


/* past quiz attempts:
 Each attempt will show details such as the quiz name, date of attempt, score, and a list of questions attempted along with their correctness.
 */


import UIKit

class QuizHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quizHistoryTitleLabel: UILabel!
    @IBOutlet weak var quizHistoryTableView: UITableView!
    
    var quizData: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizHistoryTitleLabel.text = "Quiz Attempt History"
        quizHistoryTableView.delegate = self
        quizHistoryTableView.dataSource = self
        //quizHistoryTableView.separatorColor = .clear
        
        loadQuizData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizHistoryCell", for: indexPath) as! HistoryAttemptTableViewCell
        
        let quizAttempt = quizData[indexPath.row]
        let username = quizAttempt["username"] as? String ?? "Unknown User"
        let score = quizAttempt["score"] as? String ?? "N/A"
        let date = quizAttempt["date"] as? String ?? "Unknown Date"
        
        cell.usernameLabel?.text = "Username: \(username)"
        cell.scoreLabel?.text = "Score: \(score)"
        cell.dateLabel?.text = "Date: \(date)"
        
        return cell
    }
    
    func loadQuizData() {
        let filePath = getDocumentsDirectory().appendingPathComponent("quizResultsData.txt")
        do {
            let data = try Data(contentsOf: filePath)
            let dataString = String(data: data, encoding: .utf8)
            print("Loaded data: \(dataString ?? "Invalid Data")")
            if let loadedData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                self.quizData = loadedData
                DispatchQueue.main.async {
                    self.quizHistoryTableView.reloadData()
                }
            } else {
                print("Data is not in expected format")
            }
        } catch {
            print("Failed to load quiz data: \(error)")
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            self.quizData.remove(at: indexPath.row)
            
            self.saveDataToFile()
            tableView.deleteRows(at: [indexPath], with: .fade)

            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }
    
    func saveDataToFile() {
        let filePath = getDocumentsDirectory().appendingPathComponent("quizResultsData.txt")
        do {
            let dataToSave = try JSONSerialization.data(withJSONObject: quizData, options: .prettyPrinted)
            try dataToSave.write(to: filePath, options: .atomic)
            print("Updated data saved successfully to \(filePath)")
        } catch {
            print("Failed to save updated data: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Assuming you have a storyboard setup
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "QuizDetailViewController") as? QuizDetailViewController {
            viewController.quizDetails = quizData[indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}
