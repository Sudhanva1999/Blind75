//
//  ViewController.swift
//  Blind75
//
//  Created by Sudhanva Paturkar on 13/05/24.
//

import UIKit


class ViewController: UIViewController {
    
    let questionArray = [UIImage(imageLiteralResourceName: "1q"),
                         UIImage(imageLiteralResourceName: "2q"),
                         UIImage(imageLiteralResourceName: "3q"),
                         UIImage(imageLiteralResourceName: "4q"),
                         UIImage(imageLiteralResourceName: "5q"),
                         UIImage(imageLiteralResourceName: "6q"),
                         UIImage(imageLiteralResourceName: "7q"),
                         UIImage(imageLiteralResourceName: "8q"),
                         UIImage(imageLiteralResourceName: "9q"),
                         UIImage(imageLiteralResourceName: "10q"),
                         UIImage(imageLiteralResourceName: "11q"),
                         UIImage(imageLiteralResourceName: "12q"),
                         UIImage(imageLiteralResourceName: "13q"),
    ]
    
    let answerArray = [UIImage(imageLiteralResourceName: "1a"),
                         UIImage(imageLiteralResourceName: "2a"),
                         UIImage(imageLiteralResourceName: "3a"),
                         UIImage(imageLiteralResourceName: "4a"),
                       UIImage(imageLiteralResourceName: "5a"),
                       UIImage(imageLiteralResourceName: "6a"),
                       UIImage(imageLiteralResourceName: "7a"),
                       UIImage(imageLiteralResourceName: "8a"),
                       UIImage(imageLiteralResourceName: "9a"),
                       UIImage(imageLiteralResourceName: "10a"),
                       UIImage(imageLiteralResourceName: "11a"),
                       UIImage(imageLiteralResourceName: "12a"),
                       UIImage(imageLiteralResourceName: "13a"),
    ]

    @IBOutlet weak var qtitle: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet weak var toggleButton: UIButton!
    
    var currentQuestion: Int = 0
    var questions: [Questions] = []
    var generator = RandomIndexGenerator(arraySize: 13)
    var progress = 1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        currentQuestion = generator.next()
        questions = loadQuestions()!
        updateQuestions()
        questionProgress.progress = 0.25
        toggleButton.setTitle("Show Answer", for: .normal)
    }
    
    @IBAction func questionAnswerToggle(_ sender: UIButton) {
        if(toggleButton.currentTitle == "Show Answer") {
            toggleButton.setTitle("Show Question", for: .normal)
            imageView.image = answerArray[currentQuestion]
            
        } else {
            toggleButton.setTitle("Show Answer", for: .normal)
            imageView.image = questionArray[currentQuestion]
        }
    }
    
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        progress += 1
        if(progress > 13) {
            progress = 1
        }
        currentQuestion = generator.next()
        updateQuestions()
        questionProgress.progress = Float(progress) / 13.0
    }
    
    func updateQuestions() {
        qtitle.text = questions[currentQuestion].title
        category.text = questions[currentQuestion].pattern
        difficulty.text = questions[currentQuestion].difficulty
        imageView.image = questionArray[currentQuestion]
        
    }
    
    func loadQuestions() -> [Questions]? {
            if let url = Bundle.main.url(forResource: "questionData", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let questions = try decoder.decode([Questions].self, from: data)
                    return questions
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("File not found")
            }
            return nil
        }

}

