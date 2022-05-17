//
//  QuestionVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class QuestionVC: UIViewController {

    @IBOutlet weak var questionTableController: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    var questionTableDandD = QuestionTableDataAndDelegate()
    var subMittedAnswer: String = "";
    var correctAnswer: String = "";
    
    var quizAdmin: HardCodedQuizAdmin?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = quizAdmin!.getCurrentQuestion().question
        questionTableDandD.vc = self;
        questionTableDandD.descriptions = quizAdmin!.getCurrentQuestion().listOfAnswers
        questionTableController.dataSource = questionTableDandD;
        questionTableController.delegate = questionTableDandD;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings Placeholder", message: "Settings pressed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }

    @IBAction func submitPressed(_ sender: Any) {
        if(subMittedAnswer != ""){
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "answerVC") as! AnswerVC
            newViewController.userAnswerString = subMittedAnswer;
            newViewController.correctAnswerString = quizAdmin!.getCurrentCorrectAnswer();
            newViewController.quizAdmin = quizAdmin;
            self.present(newViewController, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "You haven't answered the question!", message: "Click on an answer first!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: false)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        self.present(newViewController, animated: true, completion: nil)

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
