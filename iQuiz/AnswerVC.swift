//
//  AnswerVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class AnswerVC: UIViewController {

    var correctAnswerString: String = ""
    var userAnswerString: String = ""
    var quizAdmin: JSONQuizAdmin?
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var userAnswerLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctAnswerLabel.text = correctAnswerString;
        userAnswerLabel.text = userAnswerString;
        
        var gradeString = "You answered "
        if(correctAnswerString == userAnswerString){
            gradeString = gradeString + "correctly!"
            quizAdmin!.correctSoFar = quizAdmin!.correctSoFar + 1
        }
        else {
            gradeString = gradeString + "incorrectly"
        }
        quizAdmin!.currentQuestion = quizAdmin!.currentQuestion + 1
        gradeLabel.text = gradeString
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if(quizAdmin!.currentQuestion == quizAdmin!.currentQuiz!.listOfQuestions.count){
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "finishedVC") as! FinishedVC
            newViewController.quizAdmin = quizAdmin!
            self.present(newViewController, animated: true, completion: nil)
        }
        else{
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "questionVC") as! QuestionVC
            newViewController.quizAdmin = quizAdmin!
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings Placeholder", message: "Settings pressed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
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
