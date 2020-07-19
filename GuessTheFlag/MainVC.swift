//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Mahmoud Nasser on 7/9/20.
//  Copyright © 2020 Mahmoud Nasser. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var btn1: UIButton! { didSet {
        btn1.tag = 0
        setBtnsConfig(btn: btn1)


    } }
    @IBOutlet weak var btn2: UIButton! { didSet {
        btn2.tag = 1
        setBtnsConfig(btn: btn2)


    } }
    @IBOutlet weak var btn3: UIButton! { didSet {
        btn3.tag = 2
        setBtnsConfig(btn: btn3)

    } }

    @IBOutlet weak var answerLbl: UILabel!

    @IBOutlet var answersLblCollection: [UILabel]! { didSet {
        answersLblCollection.forEach { (label) in
            var tag = 0
            label.tag = 0
            tag += 1
        }
    } }

    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var newGameBtn: UIButton!


    //MARK: variables
    var countries = ["estonia", "monaco", "nigeria", "spain", "italy", "us", "uk", "france", "germany", "ireland", "poland", "russia"]
    var correctAnswer = Int.random(in: 0...2)
    var answers = [Bool]()
    var score = 0
    
    //MARK: app life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("shuffle")
        print(countries)

        self.title = "SELECT " + countries[correctAnswer].uppercased()
        askQuestion()

    }

    //MARK: functions
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        setBtnsImage(btn: btn1)
        setBtnsImage(btn: btn2)
        setBtnsImage(btn: btn3)
        self.title = "SELECT " + countries[correctAnswer].uppercased()
    }

    func setBtnsConfig(btn: UIButton) {
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
    }

    func setBtnsImage(btn: UIButton) {
        btn.setImage(UIImage(named: countries[btn.tag]), for: .normal)
    }

    func setAnswerLblTitles(isCorrect: Bool) {
        answerLbl.font = UIFont.boldSystemFont(ofSize: 30)
        if isCorrect {
            answerLbl.text = "Correct!"
            answerLbl.textColor = UIColor.green
            answers.append(true)

        } else {
            answerLbl.text = "Wrong!"
            answerLbl.textColor = UIColor.red
            answers.append(false)
        }
    }

    func addAnswerLbl(isCorrect: Bool) {
        let textLabel = UILabel()
        textLabel.text = isCorrect ? "Correct" : "Wrong"
        textLabel.textAlignment = .center
        textLabel.textColor = isCorrect ? .green : .red
        answersStackView.addArrangedSubview(textLabel)
    }

    func showNewGameAlert(){
        let alert = UIAlertController(title: "Start New Game", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { (action) in
            self.askQuestion()
        }))
        self.present(alert, animated: true, completion: {
            self.answers.removeAll()
        })
    }
    
    //MARK: IBActions
    @IBAction func selectFlagBtn(_ sender: UIButton) {
        print(correctAnswer, sender.tag)
        print(countries[sender.tag])
        if sender.tag == correctAnswer {
            setAnswerLblTitles(isCorrect: true)
            addAnswerLbl(isCorrect: true)
            score += 10
        } else {
            setAnswerLblTitles(isCorrect: false)
            addAnswerLbl(isCorrect: false)
            score -= 10
        }
        if answers.count < 6 { askQuestion() } else { showNewGameAlert() }
        scoreLbl.text = String(score)
    }

    @IBAction func newGameBtnTapped(_ sender: UIButton) {
        answerLbl.text = ""
        askQuestion()
        answers.removeAll()
        outerStackView.removeArrangedSubview(answersStackView)
        outerStackView.addArrangedSubview(answersStackView)
    }
}

