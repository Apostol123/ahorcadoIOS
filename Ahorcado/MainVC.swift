//
//  MainVC.swift
//  Ahorcado
//
//  Created by user159106 on 8/10/20.
//  Copyright © 2020 user159106. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    var numberOfTriesCount = 7
    
    lazy var numberOfTries: UILabel = {
        var triesLabel = UILabel(frame: .zero)
        triesLabel.text = "Attempts left:  \(numberOfTriesCount) "
        triesLabel.translatesAutoresizingMaskIntoConstraints = false
        return triesLabel
    }()
    
    lazy var  word = wordsArray.randomElement()!
    lazy var hiddenWord = String(word.map { _ in Character("?") })
    lazy var wordLabel: UILabel = {
        var wordLabel = UILabel(frame: .zero)
        wordLabel.font = UIFont(name: "AvenirNext-bold", size: 24)
        
        
        wordLabel.text = hiddenWord
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        return wordLabel
    }()
    
    let wordsArray = ["Homer", "Lisa", "Marge", "Bart", "Mou", "Lenny", "Carl"]
    
    lazy var enterLetter: UITextField = {
        var enterLetter = UITextField(frame: .zero)
        enterLetter.font = UIFont(name: "AvenirNext-Bold", size: 18)
        enterLetter.text = "Enter a letter"
        enterLetter.addTarget(self, action: #selector(enterLetterRules), for: .editingDidBegin)
        enterLetter.delegate = self
        enterLetter.translatesAutoresizingMaskIntoConstraints =  false
        return enterLetter
    }()
    
    let button: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.textColor = .black
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var chooseLetterContainer: UIView = {
        var view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseLetterStackView)
        NSLayoutConstraint.activate(
            [chooseLetterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
             chooseLetterStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -8),
             chooseLetterStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
             chooseLetterStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
            ]
        )
        
        return view
    }()
    
    lazy var chooseLetterStackView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var chooseWord: UILabel = {
        var chooseWord = UILabel(frame: .zero)
        chooseWord.font = UIFont(name: "AvenirNext", size: 12)
        chooseWord.text = "Test Choose Word"
        chooseWord.translatesAutoresizingMaskIntoConstraints = false
        return chooseWord
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = true
        
        configureTriesLabel()
        configureGuessWordLabel()
        configureEnterLetterLabel()
        configureSubmittButton()
        
    }
    
    func configureTriesLabel() {
        view.addSubview(numberOfTries)
        numberOfTries.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        numberOfTries.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    var usedLetters = [String]()
    
    @objc func submit() {
        self.view.endEditing(true)
        wordLabel.text = ""
        word = word.lowercased()
        usedLetters.append(enterLetter.text!.lowercased())
        wordLabel.text = ""
        
        for letter in word {
            if usedLetters.contains(String(letter)) {
                wordLabel.text! += String(letter)
            } else {
                wordLabel.text! += "?"
            }
        }
        
        if !word.contains(usedLetters.last!){
            numberOfTriesCount -= 1
            numberOfTries.text = "Attempts left:  \(numberOfTriesCount) "
        }
        
        if word == wordLabel.text! {
            let alertController = UIAlertController(title: "You Have Won", message: "Congratz you've won!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive) { (_) in
                self.restartGame()
            })
                
            self.present(alertController, animated: true)
            
        } else if numberOfTriesCount == 0 {
            let alertController = UIAlertController(title: "You Have Lost", message: "You have lost try AGAIN", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .destructive) { (_) in
                self.restartGame()
            })
            self.present(alertController, animated: true)
        }
        
    
    }
    
    
    
    
    
    func configureGuessWordLabel() {
        view.addSubview(wordLabel)
        wordLabel.topAnchor.constraint(equalTo: numberOfTries.bottomAnchor, constant: 24).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: numberOfTries.centerXAnchor).isActive = true
    }
    
    func configureEnterLetterLabel() {
        view.addSubview(enterLetter)
        enterLetter.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 24).isActive = true
        enterLetter.centerXAnchor.constraint(equalTo: wordLabel.centerXAnchor).isActive = true
    }
    
    func configureSubmittButton() {
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: enterLetter.bottomAnchor, constant: 24).isActive = true
        button.centerXAnchor.constraint(equalTo: enterLetter.centerXAnchor).isActive = true
    }
    
    @objc func enterLetterRules() {
        enterLetter.text = ""
    }
    
    func restartGame() {
        word = wordsArray.randomElement()!
        hiddenWord = String(word.map { _ in Character("?") })
        numberOfTriesCount = 7
        numberOfTries.text = "Attempts left: \(numberOfTriesCount)"
        wordLabel.text = hiddenWord
        
    }
    
    func configureChooseWord() {
        for i in 0...10 {
            var stackView = UIStackView(frame: .zero)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            for j in 0...3 {
                var chooseWord: UILabel = {
                    var chooseWord = UILabel(frame: .zero)
                    chooseWord.font = UIFont(name: "AvenirNext", size: 12)
                    chooseWord.text = "Test: \(i) "
                    chooseWord.translatesAutoresizingMaskIntoConstraints = false
                    return chooseWord
                }()
                stackView.addArrangedSubview(chooseWord)
            }
            
            chooseLetterStackView.addArrangedSubview(stackView)
        }
        view.addSubview(chooseLetterContainer)
        chooseLetterContainer.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        chooseLetterContainer.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
    }
}

extension MainVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count > 0 {
            return false
        } else {
            return true
        }
    }
}
