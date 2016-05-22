//
//  ViewController.swift
//  Calculator
//
//  Created by hackintosh on 5/8/16.
//  Copyright © 2016 bromodachi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = ""
        case Clear = "Clear"
    }
    @IBOutlet weak var outputLbl:UILabel!
    
    var btnSound: AVAudioPlayer!
    var inputNumber = ""
    
    var leftValue = "0"
    var rightValue = ""
    var currentOperation:Operation = Operation.Empty
    var results = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!, isDirectory: false)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(btn: UIButton){
        playSound()
        if inputNumber.characters.count == 1 && inputNumber == "0"{
            inputNumber = "\(btn.tag)"
        }
        else{
            inputNumber += "\(btn.tag)"
        }
        
        outputLbl.text = inputNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
    }
    
    func processOperation(op: Operation){
        playSound()
        if currentOperation != Operation.Empty && currentOperation != Operation.Clear &&  op != Operation.Clear{
            
            if inputNumber != "" {
                rightValue = inputNumber
                inputNumber = ""
                print(leftValue)
                print(rightValue)
                if currentOperation == Operation.Multiply{
                    results = "\(Double(leftValue)! * Double(rightValue)!)"
                }
                else if currentOperation == Operation.Divide{
                    results = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                else if currentOperation == Operation.Add{
                    results = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                else {
                    results = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                
                leftValue = results
                
                outputLbl.text = results
            }
            currentOperation = op
        }
        else if op == Operation.Clear {
            resetAll()
            
        }
        else{
            //first time so we don't do any math
            //print(inputNumber)
            if inputNumber == "" {
                leftValue = "0"
            }
            else{
                leftValue = inputNumber
            }
            inputNumber = ""
            currentOperation = op
            
        }
    }
    
    func resetAll(){
        inputNumber = "0"
        leftValue = ""
        rightValue = ""
        results = "0"
        outputLbl.text = results
        currentOperation = Operation.Clear
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    

}

