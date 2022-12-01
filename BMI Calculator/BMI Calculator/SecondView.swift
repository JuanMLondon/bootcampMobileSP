//
//  SecondView.swift
//  BMI Calculator
//
//  Created by JML on 22/11/22.
//

import UIKit

class SecondView: UIViewController {
    
    var bmiValue: Float?
    
    @IBOutlet weak var resultLabelValue: UILabel!
    
    @IBOutlet weak var adviceLabelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bmiValueString = String(format: "%.2f", bmiValue!)
        resultLabelValue.text = bmiValueString
        adviceLabelValue.text = advisor(bmi: bmiValue!)
    }
    
    func advisor(bmi: Float) -> String{
        if (bmi < 18.5) {
            return "You should eat more pie!"
        } else if (bmi >= 18.5 && bmi <= 24) {
            return "You're on the right track!"
        } else if (bmi > 24 && bmi < 30) {
            return "You should eat less pie!"
        } else {
            return "You should start exercising!"
        }
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
