//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Melissa Snider on 2017-10-14.
//  Copyright © 2017 Melissa Snider. All rights reserved.
//

import Foundation


class CalculatorBrain {
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    
    private var operations: Dictionary<String, Operation> =
        ["PIE":Operation.Constant(Double.pi),
         "SQ" : Operation.UnaryOperation({-$0}),
         "e" : Operation.Constant(Double.pi),
         "cos" : Operation.UnaryOperation(cos),
         "x" : Operation.BinaryOperation({ $0 * $1}),
         "/" : Operation.BinaryOperation({ $0 / $1}),
         "+" : Operation.BinaryOperation({ $0 + $1}),
         "-" : Operation.BinaryOperation({ $0 - $1}),
         "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation( (Double) -> Double)
        case BinaryOperation( (Double, Double) -> Double)
        case Equals
    }
    
    func performOperand(symbol: String) {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation (let function): accumulator = function(accumulator)
            case .BinaryOperation (let function): pending = PendingBinaryOption(binaryFunction: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
            }
        }
    }
    
   private struct PendingBinaryOption {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    private func executePendingBinaryOperation()
    {
       if pending != nil {
        accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
        pending = nil
        }
    }
    
    private var pending:PendingBinaryOption?
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
