//
//  ViewController.swift
//  ByteCoin
//
//  Created by Sergey Zakurakin on 22/06/2024.
//

import UIKit

final class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var coinManager = CoinManager()
    
  
    
    
    //MARK: - UI
    
    private lazy var topTitleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 40, weight: .bold)
        
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var byteCoinImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "bitcoinsign.circle.fill")
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
//        element.backgroundColor = .brown
//        element.distribution = .fillEqually
        element.axis = .horizontal
        element.spacing = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var currencyStackView: UIStackView = {
        let element = UIStackView()
//        element.spacing = 30
//        element.backgroundColor = .blue
//        element.distribution = .fillEqually
        element.axis = .horizontal
        element.spacing = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var currencyLabel: UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var byteCoinLabel: UILabel = {
        let element = UILabel()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var currencyPicker: UIPickerView = {
        let element = UIPickerView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var emptyView: UIView = {
        let element = UIView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
       
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
        
    }
//MARK: - Setup View
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(topTitleLabel)
        view.addSubview(currencyStackView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(byteCoinImageView)
        mainStackView.addArrangedSubview(emptyView)
        mainStackView.addArrangedSubview(currencyStackView)
        
        currencyStackView.addArrangedSubview(currencyLabel)
        currencyStackView.addArrangedSubview(byteCoinLabel)
        
        view.addSubview(currencyPicker)
        
        
        topTitleLabel.text = "ByteCoin"
        currencyLabel.text = "..."
        byteCoinLabel.text = " USD"

//        currencyPicker.delegate = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCoin = coinManager.currencyArray[row]
        
        coinManager.getCoinPrice(for: selectedCoin)
    }
}
//MARK: - Setup Constraint
extension ViewController {
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
        
            topTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            topTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: topTitleLabel.topAnchor, constant: 100),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            byteCoinImageView.heightAnchor.constraint(equalToConstant: 50),
            byteCoinImageView.widthAnchor.constraint(equalToConstant: 50),
            
//            currencyStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            currencyStackView.topAnchor.constraint(equalTo: topTitleLabel.topAnchor, constant: 70),
////            currencyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
////            currencyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            
            currencyPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
          
        
        ])
        
        
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoint(price: String) {
        DispatchQueue.main.async {
            self.currencyLabel.text = price
        }
    }
}


//MARK: - UIPickerViewDataSource
//extension ViewController: UIPickerViewDataSource {
//    
//    
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        <#code#>
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        <#code#>
//    }
//    
//    
//}
