//
//  TransactionDetails.swift
//  Demo
//
//  Created by Darvish Kamalia on 9/15/23.
//

import Foundation

struct TransactionDetails: Codable {
    let type: String
    let id: String
    let execution: Execution
    let fee: Fee
    
    struct TransitionInput: Codable {
        let type: String
        let id: String
        let tag: String?
        let value: String?
    }

    struct TransitionOutput: Codable {
        let type: String
        let id: String
        let checksum: String?
        let value: String?
    }

    struct Transition: Codable {
        let id: String
        let program: String
        let function: String
        let inputs: [TransitionInput]
        let outputs: [TransitionOutput]
        let tpk: String
        let tcm: String
    }

    struct Fee: Codable {
        let transition: Transition
        let global_state_root: String
        let proof: String
    }

    struct Execution: Codable {
        let transitions: [Transition]
        let global_state_root: String
        let proof: String
    }
}
