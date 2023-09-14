//
//  Program.swift
//  Demo
//
//  Created by Darvish Kamalia on 9/13/23.
//

import Foundation

enum Program: Hashable {
    case auctionTesting
    case calculator
    
    var inputs: [String] {
        switch self {
        case .auctionTesting: return ["address", "fee"]
        case .calculator: return ["num1 (i32)", "num2 (i32)"]
        }
    }
    
    var programText: String {
        switch self {
        case .auctionTesting: return auctionProgramText
        case .calculator: return calculatorProgramText
        }
    }
        
    var functionName: String {
        switch self {
        case .auctionTesting: return "place_bid"
        case .calculator: return "multiply"
        }
    }
}
