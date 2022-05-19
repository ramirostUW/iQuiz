import UIKit
import Foundation
class JSONQuizAdmin {
    var currentQuiz: Quiz?
    var currentQuestion: Int!
    var correctSoFar: Int!
    var possibleQuizes: [Quiz]!
    
    init(){
        let firstMarvel = Question("What is Dr. Strange's first Name?",
                                   ["Stephen", "Dr.", "First", "Name"], 0)
        let secondMarvel = Question("What is Dr. Strange's last Name?",
                                   ["Strange", "Dr.", "Last", "Name"], 0)
        let thirdMarvel = Question("What is Dr. Strange's power?",
                                   ["Magic", "medicine", "ios development", "friendship"], 0)
        let marvelQuiz = Quiz([firstMarvel, secondMarvel, thirdMarvel], "marvel quiz", "Marvels Superheroes");
        
        let firstMath = Question("What is 1+1?",
                                ["one", "two", "three", "four"], 1)
        let secondMath = Question("What is 1+2?",
                                  ["one", "two", "three", "four"], 2)
        let thirdMath = Question("What is 1+3?",
                                 ["one", "two", "three", "four"], 3)
        let mathQuiz = Quiz([firstMath, secondMath, thirdMath], "math quiz", "Math");
        
        let firstScience = Question("Which of the following is a state of matter?",
                                ["gas", "gravity", "medicine", "Dr. Strange"], 0)
        let secondScience = Question("Which is a force",
                                ["gas", "gravity", "medicine", "Dr. Strange"], 1)
        let ThirdScience = Question("Which is a branch of science?",
                                ["gas", "gravity", "medicine", "Dr. Strange"], 2)
        let scienceQuiz = Quiz([firstScience, secondScience, ThirdScience], "science quiz", "Science");
        
        possibleQuizes = [mathQuiz, marvelQuiz, scienceQuiz]
        //possibleQuizes = getJSONQuestions()
        
        correctSoFar = 0;
        
        currentQuestion = 0;
    }
    
    func chooseQuiz(_ quizTitle: String){
        for potentialQuiz in possibleQuizes{
            if(quizTitle == potentialQuiz.title){
                self.currentQuiz = potentialQuiz
            }
        }
                    
    }
    
    func getCurrentQuestion() -> Question{
        return currentQuiz!.listOfQuestions[currentQuestion];
    }
    
    func getCurrentCorrectAnswer() -> String{
        let question = getCurrentQuestion()
        let answer = question.listOfAnswers[question.correctAnswer]
        return answer;
    }
    
    func getListOfQuizTitles() -> [String]{
        var returnVal: [String] = []
        for potentialQuiz in possibleQuizes{
            returnVal.append(potentialQuiz.title)
        }
        return returnVal;
    }
    
    func getListOfQuizDescriptions() -> [String]{
        var returnVal: [String] = []
        for potentialQuiz in possibleQuizes{
            returnVal.append(potentialQuiz.description)
        }
        return returnVal;
    }
    
    func getJSONQuestions(_ homePageTable: ViewController!){
        var greeting = "Hello, playground"

        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
        let session = URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong! \(error)")
                }
            }
            
            let httpResponse = response! as! HTTPURLResponse
            
            print(data)
            
            do {
                let questions = try JSONSerialization.jsonObject(with: data!)
                print(questions)
                if let arr = questions as? [[String: Any]] {
                    var newQuizzes: [Quiz] = []
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
                        newQuizzes.append(Quiz(questionArray, desc!, title!))
                    }
                    self.possibleQuizes = newQuizzes;
                }
            }
            catch {
                print("Something went boom")
            }
            homePageTable.reload()
        }
        session.resume()

    }
}

class TableDataAndDelegate : NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : ViewController?
    var quizAdmin: JSONQuizAdmin?
    var quizLabels : [String] = []
    
    var descriptions: [String] = []


    /*
     UITableViewDataSource methods
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizLabels.count
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        cell.textLabel!.text = quizLabels[indexPath.row]
        cell.detailTextLabel!.text = descriptions[indexPath.row]
        cell.imageView!.image = UIImage(systemName: "multiply.circle.fill")
        return cell
    }
    
    /*
     UITableViewDelegate methods
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*
        let alert = UIAlertController(title: "Selected!", message: "You selected \(quizLabels[indexPath.row])!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        vc!.present(alert, animated: true, completion: nil)
         */
        let newViewController = vc!.storyboard?.instantiateViewController(withIdentifier: "questionVC") as! QuestionVC
        let selectedLabel = quizLabels[indexPath.row]
        let newQuizAdmin = quizAdmin!
        newQuizAdmin.chooseQuiz(selectedLabel)
        newViewController.quizAdmin = newQuizAdmin
        vc!.present(newViewController, animated: true, completion: nil)

    }
    
    

}
