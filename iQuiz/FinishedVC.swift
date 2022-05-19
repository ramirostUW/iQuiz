//
//  FinishedVC.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class FinishedVC: UIViewController {

    @IBOutlet weak var finishedBlurbLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    var quizAdmin: JSONQuizAdmin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finishedBlurbLabel.text = "You finished your quiz!"
        if(quizAdmin!.correctSoFar == quizAdmin!.currentQuiz!.listOfQuestions.count){
            finishedBlurbLabel.text = "Perfect!"
        }
        gradeLabel.text = "You answered " + String(quizAdmin!.correctSoFar) + " out of " + String(quizAdmin!.currentQuiz!.listOfQuestions.count) + " correctly!";
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okayBtnTapped(_ sender: Any) {
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        self.present(newViewController, animated: true, completion: nil)

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
