//
//  ViewController.swift
//  Calculator
//
//  Created by Melissa Snider on 2017-10-14.
//  Copyright © 2017 Melissa Snider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping: Bool = false
    

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        
        if userIsInTheMiddleOfTyping {
        let textCurrentlyInDisplay = display.text
            display.text = textCurrentlyInDisplay! + digit
        } else {
            display.text = digit
        }
        
        userIsInTheMiddleOfTyping = false
    }
   private var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathemticalSymbol = sender.currentTitle{
            
            brain.performOperand(symbol: mathemticalSymbol)
        }
        displayValue = brain.result
    }
}

