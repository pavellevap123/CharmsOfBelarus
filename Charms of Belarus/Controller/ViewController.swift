//
//  ViewController.swift
//  Charms of Belarus
//
//  Created by Pavel on 6/28/20.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var buttonAppearance: UIButton!
    @IBOutlet weak var attractionTitle: UILabel!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var attractionDescription: UILabel!
    
    let base = Base()
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        buttonAppearance.layer.cornerRadius = 20
        buttonAppearance.layer.borderWidth = 1
        // Loading initial elements to the view
        attractionTitle.text = base.cities[0].attractions[0].attractionName
        flag.image = base.cities[0].attractions[0].image
        attractionDescription.text = base.cities[0].attractions[0].description
        url = base.cities[0].attractions[0].link
    }

    @IBAction func viewInWikiPressed(_ sender: UIButton) {
        guard let safeUrl = URL(string: url!) else {
            fatalError("Link wasn't parced")
        }
        UIApplication.shared.open(safeUrl, options: [:])
    }
    
}


// MARK: - PickerView DataSource Methods
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return base.cities.count
        } else {
            let selectedCity = pickerView.selectedRow(inComponent: 0)
            return base.cities[selectedCity].attractions.count
        }
    }
}


// MARK: - PickerView Delegate Methods
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return base.cities[row].name
        } else {
            let selectedCity = pickerView.selectedRow(inComponent: 0)
            return base.cities[selectedCity].attractions[row].attractionName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        if component == 0 {
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        let selectedCity = pickerView.selectedRow(inComponent: 0)
        let selectedAttraction = pickerView.selectedRow(inComponent: 1)
        // Setting all properties of chosen city and attraction to view
        attractionTitle.text = base.cities[selectedCity].attractions[selectedAttraction].attractionName
        flag.image = base.cities[selectedCity].attractions[selectedAttraction].image
        attractionDescription.text = base.cities[selectedCity].attractions[selectedAttraction].description
        url = base.cities[selectedCity].attractions[selectedAttraction].link
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        pickerView.reloadAllComponents()
        let w = pickerView.frame.size.width
        return component == 0 ? (1 / 3.0) * w : (2 / 3.0) * w
    }
    
}

