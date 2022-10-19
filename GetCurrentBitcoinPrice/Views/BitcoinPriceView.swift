//
//  BitcoinPriceView.swift
//  GetCurrentBitcoinPrice
//
//  Created by Adm Aidyn on 10/19/22.
//

import UIKit

class BitcoinPriceView: UIView {
    
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 55, weight: .thin)
        label.textAlignment = .center
        label.text = "Current rate"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var bitcoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.tintColor = UIColor(named: "AdaptiveWhite")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bitcoinRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.text = "..."
        label.numberOfLines = 0
        return label
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.text = "USD"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var coinViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bitcoinImageView, bitcoinRateLabel, currencyLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray2
        stackView.layer.cornerCurve = .continuous
        stackView.layer.cornerRadius = 20
        return stackView
    }()
    
    lazy var currencyPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        addSubview(appNameLabel)
        constraints.append(appNameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 230))
        constraints.append(appNameLabel.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(appNameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor))
        constraints.append(appNameLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor))
        constraints.append(appNameLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor))
        
        addSubview(coinViewStackView)
        constraints.append(coinViewStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor))
        constraints.append(coinViewStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor))
        constraints.append(coinViewStackView.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 20))
        constraints.append(coinViewStackView.heightAnchor.constraint(equalToConstant: 80))
        
        constraints.append(bitcoinImageView.widthAnchor.constraint(equalToConstant: 80))
        constraints.append(bitcoinImageView.heightAnchor.constraint(equalToConstant: 60))

        
        addSubview(currencyPickerView)
        constraints.append(currencyPickerView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor))
        constraints.append(currencyPickerView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor))
        constraints.append(currencyPickerView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
