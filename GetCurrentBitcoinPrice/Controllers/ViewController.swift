//
//  ViewController.swift
//  GetCurrentBitcoinPrice
//
//  Created by Adm Aidyn on 10/19/22.
//

import UIKit

class ViewController: UIViewController {
    
    var bitcoinPriceView = BitcoinPriceView()
    
    var coinManager = CoinManager()
    
    override func loadView() {
        super.loadView()
        self.view = bitcoinPriceView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        coinManager.delegate = self
        bitcoinPriceView.currencyPickerView.delegate = self
        bitcoinPriceView.currencyPickerView.dataSource = self
    }
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        bitcoinPriceView.currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, currencyRate: CoinModel) {
        DispatchQueue.main.async {
            let finalRate = String(format: "%.2f",  currencyRate.currencyRate)
            self.bitcoinPriceView.bitcoinRateLabel.text = finalRate
        }
    }
    func didFailWithError(error: Error) {
        print(error)
        DispatchQueue.main.async {
            self.bitcoinPriceView.bitcoinRateLabel.text = "error occured"
            self.bitcoinPriceView.bitcoinRateLabel.textColor = .systemRed
        }
    }
}
