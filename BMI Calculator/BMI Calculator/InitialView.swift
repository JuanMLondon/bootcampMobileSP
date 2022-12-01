//
//  ViewController.swift
//  BMI Calculator
//
//  Created by JML on 22/11/22.
//

import UIKit

class InitialView: UIViewController {
    
    var height: Float = 1.50
    var weight: Float = 53
    var bmiValue: Float = 0

    @IBOutlet weak var heightLabelV: UILabel!
    
    @IBOutlet weak var weightLabelV: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        height = sender.value
        heightLabelV.text = "\(String(format: "%.2f", height))m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weight = sender.value
        weightLabelV.text = "\(String(format: "%.0f", weight))Kg"
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        bmiValue = weight / pow(height, 2)
        performSegue(withIdentifier: "goToSecondView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goToSecondView" {
            let destinationVC = segue.destination as! SecondView
            destinationVC.bmiValue = bmiValue
        }
    }
}

