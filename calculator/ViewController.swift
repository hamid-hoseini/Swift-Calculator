//
//  ViewController.swift
//  calculator
//
//  Created by hamid on 6/12/17.
//  Copyright © 2017 hamid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var userIsTyping = false

    @IBOutlet private weak var display: UILabel!

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        let textCurrentlyInDisplay = display.text!
        if userIsTyping{
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTyping = true
        //print ("touched \(digit) digit")
    }
    
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    var saveProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        saveProgram = brain.program
    }
    
    @IBAction func restore() {
        if (saveProgram != nil) {
            brain.program = saveProgram!
            displayValue = brain.result
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {

        if userIsTyping {
            brain.setOperand(operand: displayValue)
            userIsTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)

        }
        displayValue = brain.result
    }
}

