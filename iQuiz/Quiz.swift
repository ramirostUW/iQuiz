//
//  Quiz.swift
//  iQuiz
//
//  Created by Matthew Karyadi on 5/16/22.
//

import Foundation
import UIKit

class Quiz {
    var listOfQuestions: [Question]!
    var description: String!
    var title: String!
    init(_ myQuestions: [Question]!, _ description: String, _ title: String) {
        self.listOfQuestions = myQuestions;
        self.description = description;
        self.title = title;
    }
}

class Question {
    var correctAnswer: Int!
    var listOfAnswers: [String]!
    var question: String;
    init( _ myQuestion: String, _ myAnswers: [String]!, _ correntAnswer: Int!){
        self.correctAnswer = correntAnswer;
        self.listOfAnswers = myAnswers;
        self.question = myQuestion;
    }
}

class HardCodedQuizAdmin {
    var currentQuiz: Quiz!
    var currentQuestion: Int!
    var correctSoFar: Int!
    init(_ quizTopic: String!){
        let firstMarvel = Question("What is Dr. Strange's first Name?",
                                   ["Stephen", "Dr.", "First", "Name"], 0)
        let secondMarvel = Question("What is Dr. Strange's last Name?",
                                   ["Strange", "Dr.", "Last", "Name"], 0)
        let thirdMarvel = Question("What is Dr. Strange's power?",
                                   ["Magic", "medicine", "ios development", "friendship"], 0)
        let marvelQuiz = Quiz([firstMarvel, secondMarvel, thirdMarvel], "marvel quiz", "marvel");
        
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
        let scienceQuiz = Quiz([firstScience, secondScience, ThirdScience], "science quiz", "Sience");
        
        
        if(quizTopic == "Math"){
            self.currentQuiz = mathQuiz;
        }
        else if (quizTopic == "Marvel Superheroes"){
            self.currentQuiz = marvelQuiz;
        }
        else {
            self.currentQuiz = scienceQuiz;
        }
        self.currentQuestion = 0;
        self.correctSoFar = 0;
        
        
    }
    
    func getCurrentQuestion() -> Question{
        return currentQuiz.listOfQuestions[currentQuestion];
    }
    
    func getCurrentCorrectAnswer() -> String{
        let question = getCurrentQuestion()
        let answer = question.listOfAnswers[question.correctAnswer]
        return answer;
    }
}
