//
//  ViewController.swift
//  TicTacToe
//
//  Created by Pudilic Seby on 25.03.2022.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var player1score: UILabel!
    @IBOutlet weak var player2score: UILabel!
    
    @IBOutlet weak var player1name: UIButton!
    @IBOutlet weak var player2name: UIButton!
    
    
    var currentTurn = Turn.Cross
    var firstTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtsScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        turnLabel.text = CROSS + " turn"
        turnLabel.textColor = .systemOrange
        
        
        initBoard()
    }
    
    func initBoard() {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    @IBAction func cellClicked(_ sender: UIButton) {
        addToBoard(sender)
        
        if checkForVictory(CROSS) {
            crossesScore += 1
            player1score.text = String(crossesScore)
            turnLabel.text = ""
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            resultAlert(title: "X wins")
        }
        
        if checkForVictory(NOUGHT) {
            noughtsScore += 1
            player2score.text = String(noughtsScore)
            turnLabel.text = ""
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            resultAlert(title: "O wins")
        }
        
        if(fullBoard()) {
            resultAlert(title: "DRAW")
        }
        
    }
    
    func checkForVictory(_ s: String) -> Bool {
        
        // Pe orizontala
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) { return true }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) { return true }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) { return true }
        
        // Pe verticala
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) { return true }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) { return true }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) { return true }
        
        // Pe diagonala
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) { return true }
        if thisSymbol(c1, s) && thisSymbol(b2, s) && thisSymbol(a3, s) { return true }
        
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard(){
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Nought) {
            firstTurn = Turn.Cross
            turnLabel.text = CROSS + " turn"
            turnLabel.textColor = .systemOrange
        } else if(firstTurn == Turn.Cross){
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT + " turn"
            turnLabel.textColor = .systemPink
        }
        
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil { return false }
        }
        return true
    }
    
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            if(currentTurn == Turn.Nought) {
                sender.setTitle(NOUGHT, for: .normal)
                sender.setTitleColor(.systemPink, for: .normal)
                
                turnLabel.text = CROSS + " turn"
                turnLabel.textColor = .systemOrange
                
                currentTurn = Turn.Cross
            }
            else if(currentTurn == Turn.Cross) {
                sender.setTitle(CROSS, for: .normal)
                sender.setTitleColor(.systemOrange, for: .normal)
                
                turnLabel.text = NOUGHT + " turn"
                turnLabel.textColor = .systemPink
                
                currentTurn = Turn.Nought
            }
            sender.isEnabled = false
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        // aici fa o alerta daca e sigur ca vrem sa facem asta la confirmare, sa nu pierdem tot progresul
        
        
        let alertController = UIAlertController(title: "Do you want to reset the score?",message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            
            self.resetBoard()
            self.noughtsScore = 0
            self.crossesScore = 0
            self.player2score.text = String("0")
            self.player1score.text = String("0")
            self.currentTurn = Turn.Cross
            self.firstTurn = Turn.Cross
            self.turnLabel.text = self.CROSS + " turn"
            self.turnLabel.textColor = .systemOrange
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped")
        }
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    }
    
    
}

