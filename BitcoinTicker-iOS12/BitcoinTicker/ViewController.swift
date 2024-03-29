//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire



class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // select one of the component
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        finalURL = baseURL + currencyArray[row]
        getBitCoinInfo(url: finalURL)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
       
    }
    private func updateBitCoinData(json: JSON){
        if let bitcoinResult = json["ask"].double{
            bitcoinPriceLabel.text = "\(bitcoinResult)"
        }else{
            bitcoinPriceLabel.text = "Price Unavailable"
        }
        
    }
    private func getBitCoinInfo(url: String){
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{ response in
            if response.result.isSuccess{
                let bitcoinJSON: JSON = JSON(response.result.value!)
                self.updateBitCoinData(json: bitcoinJSON)
            }else{
                print("errorL \(String(describing: response.result.error))")
            }
        }
    }
}

