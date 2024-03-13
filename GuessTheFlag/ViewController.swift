//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Rodrigo Cavalcanti on 07/03/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentRound = 0
    let totalRounds = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        configureButtonLayout()
        askQuestion()
    }
    
    func configureButtonLayout() {
        for button in [button1, button2, button3] {
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if currentRound >= 10 {
            currentRound = 0
            score = 0
        } else {
            currentRound += 1
        }
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        updateNavBarItems()
    }
    
    func updateNavBarItems() {
        attachLabelButtonToNavBar(
            label: "Round: \(currentRound)/\(totalRounds)",
            toTheLeft: true
        )
        
        attachLabelButtonToNavBar(
            label: "Score: \(score)",
            toTheLeft: false
        )
    }
    func attachLabelButtonToNavBar(label: String, toTheLeft: Bool) {
        let labelView = UILabel()
        labelView.text = label
        let labelButton = UIBarButtonItem(customView: labelView)
        if toTheLeft {
            navigationItem.leftBarButtonItem = labelButton
        } else {
            navigationItem.rightBarButtonItem = labelButton
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        updateNavBarItems()
        
        let didFinishAllRounds = currentRound == totalRounds
        var message = "Your\(didFinishAllRounds ? " final" : "") score is: \(score)"
        var alertActionLabel = didFinishAllRounds ? "Play again" : "Continue"
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: alertActionLabel, style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
}
