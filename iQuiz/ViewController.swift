//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tableDataAndDelegate = TableDataAndDelegate()
    var myQuizAdmin = JSONQuizAdmin()
    @IBOutlet weak var homePageTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableDataAndDelegate.quizLabels = myQuizAdmin.getListOfQuizTitles()
        tableDataAndDelegate.descriptions = myQuizAdmin.getListOfQuizDescriptions()
        tableDataAndDelegate.vc = self;
        tableDataAndDelegate.quizAdmin = myQuizAdmin
        
        homePageTable.dataSource = tableDataAndDelegate;
        homePageTable.delegate = tableDataAndDelegate;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        myQuizAdmin.getJSONQuestions(homePageTable)
        tableDataAndDelegate.quizLabels = myQuizAdmin.getListOfQuizTitles()
        tableDataAndDelegate.descriptions = myQuizAdmin.getListOfQuizDescriptions()
        let alert = UIAlertController(title: "Settings Placeholder", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
        
    }
    
    func reload(){
        homePageTable.reloadData()
    }

}

