//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tableDataAndDelegate = TableDataAndDelegate()
    
    @IBOutlet weak var homePageTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDataAndDelegate.vc = self;
        
        homePageTable.dataSource = tableDataAndDelegate;
        homePageTable.delegate = tableDataAndDelegate;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings Placeholder", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }

}

