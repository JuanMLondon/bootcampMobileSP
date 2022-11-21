//
//  ViewController.swift
//  Challenge2
//
//  Created by JML on 21/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView: UIImageView!
    
    let diceArray = [UIImage (named: "dice_1"), UIImage (named: "dice_2"), UIImage (named: "dice_3"), UIImage (named: "dice_4"), UIImage (named: "dice_5"), UIImage (named: "dice_6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diceImageView.alpha = 0.3
        diceImageView.image = diceArray[Int.random(in: 0...5)]
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        diceImageView.alpha = 1
        diceImageView.image = diceArray[Int.random(in: 0...5)]
    }
}

