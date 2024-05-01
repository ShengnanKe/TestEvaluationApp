//
//  TestSignUpViewController.swift
//  TestEvaluationApp
//
//  Created by KKNANXX on 4/30/24.
//

import UIKit

class TestSignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var testSignUpLabel: UILabel!
    @IBOutlet weak var testSignUpTableView: UITableView!
    
    var testSignUpData: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSignUpTableView.delegate = self
        testSignUpTableView.dataSource = self
        testSignUpTableView.separatorColor = .clear
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.setValue(testSignUpData, forKey: "userData")
        testSignUpTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 230.0
//        } else if indexPath.section == 1{
//            return 110.0
//        }else {
            return 100.0
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 || section == 1 {
//            return 2
//        }
//        else {
            return 1
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "SignUpCell", for: indexPath) as? SignUpTableViewCell
            
            switch indexPath.row {
            case 0:
                cell?.testTakerLabel.text = "Test Taker Name"
                cell?.testTakerTextField.text = ""
                cell?.testTakerTextField.tag = indexPath.row
            case 1:
                cell?.testTakerLabel.text = "Last Name"
                cell?.testTakerTextField.text = ""
                cell?.testTakerTextField.tag = indexPath.row
            default:
                cell?.testTakerLabel.text = "Last Name"
                cell?.testTakerTextField.text = ""
                cell?.testTakerTextField.tag = indexPath.row
            }
            
            /*
             // MARK: - Navigation
             
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */
            
        }
