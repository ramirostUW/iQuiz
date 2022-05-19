//
//  ViewController.swift
//  iQuiz
//
//  Created by stlp on 5/10/22.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    var tableDataAndDelegate = TableDataAndDelegate()
    var myQuizAdmin = JSONQuizAdmin()
    var JSONSource: URL! = URL(string: "https://tednewardsandbox.site44.com/questions.json")
    @IBOutlet weak var homePageTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let test =  UserDefaults.standard.object(forKey: "jsonURL") as? String ?? String()
        if(test != ""){
            JSONSource = URL(string: test)
            print("pulled stored url")
        }
        
        
        print(JSONSource.absoluteString)
        tableDataAndDelegate.quizLabels = myQuizAdmin.getListOfQuizTitles()
        tableDataAndDelegate.descriptions = myQuizAdmin.getListOfQuizDescriptions()
        tableDataAndDelegate.vc = self;
        tableDataAndDelegate.quizAdmin = myQuizAdmin
        
        homePageTable.dataSource = tableDataAndDelegate;
        homePageTable.delegate = tableDataAndDelegate;

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        getJSONQuestions()
    }
    @IBAction func testBtn(_ sender: Any) {
        //FilesManager().readFile(myQuizAdmin, tableDataAndDelegate, homePageTable)
        //FilesManager().writeFile(myQuizAdmin.possibleQuizes)
    }
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings Placeholder", message: "Settings go here", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .URL
            textField.text = self.JSONSource.absoluteString
        }
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { _ in
            self.JSONSource = URL(string: alert.textFields![0].text!)!
            self.getJSONQuestions()
            let defaults = UserDefaults.standard.set(alert.textFields![0].text!, forKey: "jsonURL")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alert, animated: false)
        
    }

    
    func getJSONQuestions() {
        if(myQuizAdmin.checkWifi()){
            let session = URLSession.shared.dataTask(with: JSONSource!) {
                data, response, error in
                
                
                if response != nil {
                    if (response! as! HTTPURLResponse).statusCode != 200 {
                    }
                }
                
                
                
                do {
                    let questions = try JSONSerialization.jsonObject(with: data!)
                    print(questions)
                    if let arr = questions as? [[String: Any]] {
                        self.myQuizAdmin.possibleQuizes = []
                        for quizJSON in arr {
                            let title = quizJSON["title"] as? String
                            let desc = quizJSON["desc"] as? String
                            let questionsArrJSON = quizJSON["questions"] as? [[String: Any]]
                            var questionArray : [Question] = []
                            for questionsJSON in questionsArrJSON! {
                                let text = questionsJSON["text"] as! String
                                let answers = questionsJSON["answers"] as! [String]
                                let correct = Int(questionsJSON["answer"] as! String)! - 1
                                questionArray.append(Question(text, answers, correct))
                            }
                            self.myQuizAdmin.possibleQuizes .append(Quiz(questionArray, desc!, title!))
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableDataAndDelegate.quizLabels = self.myQuizAdmin.getListOfQuizTitles()
                        self.tableDataAndDelegate.descriptions = self.myQuizAdmin.getListOfQuizDescriptions()
                        self.homePageTable.reloadData()
                        FilesManager().writeFile(self.myQuizAdmin.possibleQuizes)
                        
                    }
                }
                catch {
                    print("Something went boom")
                }

            }
            session.resume()
        }
        else {
            let alert = UIAlertController(title: "You don't have wifi!", message: "Turn on and wifi and try again! Would you like to load an offline backup?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
                FilesManager().readFile(myQuizAdmin, tableDataAndDelegate, self.homePageTable, self)
            }))
            self.present(alert, animated: false)
        }

    }

    func presentNoBackupError(){
        let alert = UIAlertController(title: "No backup found!", message: "Boot the app at least once with WiFi to automatically make a backup.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }
}

