//
//  ViewController.swift
//  ByteCoin
//
//  Created by Johnson Olusegun on 11/1/20.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    // network manager
    var coinNetworkManager = CoinNetworkManager()
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLbl: UILabel!
    
    @IBOutlet weak var exchangeLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //set the datasoucece
        currencyPicker.dataSource = self
        //set the deligate
        currencyPicker.delegate = self
        
        // CoinNetworkManagerDelegate
        coinNetworkManager.delegate = self
        
    }


}


//MARK:- Picker DataSource
extension ByteCoinViewController:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinNetworkManager.currencyArray.count
    }
    
    
}

//MARK:- Picker Delegate
extension ByteCoinViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinNetworkManager.currencyArray[row]
    }
    
    
    // didSelectRow
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinNetworkManager.setExchangeRate(with: row)
    }
    
}

//MARK:- COIN MANAGER DELEGATE
extension ByteCoinViewController:CoinNetworkManagerDelegate{
    func didFailWithError(_ error: Error) {
        print("fail")
    }
    
    func didGetResult(_ result: CoinExchangeModel) {
        
        //update the UI
        DispatchQueue.main.async {
            self.currencyLbl.text = String(result.asset_id_quote)
            self.exchangeLbl.text = result.currentRate
        }
        
    }
    
    
}

