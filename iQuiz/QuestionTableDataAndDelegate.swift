//
//  QuestionTableDataAndDelegate.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import UIKit

class QuestionTableDataAndDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : QuestionVC?
    
    let quizLabels : [String] = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J"
    ]
    
    var descriptions: [String] = [
        "First Answer", "Second Answer", "Third Answer", "Fourth Answer"
    ]

    /*
     UITableViewDataSource methods
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
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
        vc!.subMittedAnswer = descriptions[indexPath.row]
        vc!.correctAnswer = "Third Answer"
        
        /*
        let newViewController = vc!.storyboard?.instantiateViewController(withIdentifier: "questionVC") as! QuestionVC

        vc!.present(newViewController, animated: true, completion: nil)
         */

    }

}
