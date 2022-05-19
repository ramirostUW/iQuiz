//
//  FilesManager.swift
//  iQuiz
//
//  Created by stlp on 5/19/22.
//

import Foundation
import UIKit
class FilesManager {
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    func writeFile(_ quizes: [Quiz]){
        let url = getDocumentsDirectory().appendingPathComponent("quizBackup.json")

        do {
            let peopleJson = try JSONEncoder().encode(quizes)
            let peopleJsonString = String(data: peopleJson, encoding: .utf8)!
            try peopleJsonString.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readFile(_ quizAdmin: JSONQuizAdmin, _ tableDataAndDelegate: TableDataAndDelegate, _ homePageTable: UITableView!, _ vc: ViewController!){
        do{
            let url = getDocumentsDirectory().appendingPathComponent("quizBackup.json")
            let input = try String(contentsOf: url)
            //print(input)
            let dataFromJsonString = input.data(using: .utf8)
            do {
                let questions = try JSONSerialization.jsonObject(with: dataFromJsonString!)
                if let arr = questions as? [[String: Any]] {
                    quizAdmin.possibleQuizes = []
                    for quizJSON in arr {
                        let title = quizJSON["title"] as? String
                        let desc = quizJSON["description"] as? String
                        let questionsArrJSON = quizJSON["listOfQuestions"] as? [[String: Any]]
                        var questionArray : [Question] = []
                        for questionsJSON in questionsArrJSON! {
                            let text = questionsJSON["question"] as! String
                            let answers = questionsJSON["listOfAnswers"] as! [String]
                            let correct = Int(exactly: questionsJSON["correctAnswer"] as! Int)!
                            questionArray.append(Question(text, answers, correct))
                        }
                        quizAdmin.possibleQuizes .append(Quiz(questionArray, desc!, title!))
                    }
                }
                DispatchQueue.main.async {
                    tableDataAndDelegate.quizLabels =   quizAdmin.getListOfQuizTitles()
                    tableDataAndDelegate.descriptions = quizAdmin.getListOfQuizDescriptions()
                    homePageTable.reloadData()
                    
                }
            }
            catch {
                print("Something went boom")
            }
                //let cityFromData = try JSONDecoder().decode(Quiz.self, from: dataFromJsonString)
                
                //print(cityFromData.name)
            
        }
        catch{
            if(error.localizedDescription == "The file “quizBackup.json” couldn’t be opened because there is no such file."){
                vc.presentNoBackupError()
            }
            else{
                print(error.localizedDescription)
            }
            
        }
    }
}
