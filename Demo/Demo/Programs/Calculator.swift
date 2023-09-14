//
//  calculator.swift
//  Demo
//
//  Created by Darvish Kamalia on 9/13/23.
//

import Foundation

let calculatorProgramText = """
program calculator.aleo;

function addition:
    input r0 as i32.private;
    input r1 as i32.private;
    add r0 r1 into r2;
    output r2 as i32.private;

function subtract:
    input r0 as i32.private;
    input r1 as i32.private;
    sub r0 r1 into r2;
    output r2 as i32.private;

function multiply:
    input r0 as i32.private;
    input r1 as i32.private;
    mul r0 r1 into r2;
    output r2 as i32.private;

function divide:
    input r0 as i32.private;
    input r1 as i32.private;
    div r0 r1 into r2;
    output r2 as i32.private;
"""
