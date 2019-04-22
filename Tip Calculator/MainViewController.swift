//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Sherman Shi on 4/16/19.
//  Copyright © 2019 Sherman Shi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var billBeforeTip = Float()
    var billAmount = Int()
    var billAfterTip = Float()
    
    private let myBillTextView: UITextView = {
        let textView = UITextView()
        let text = "My Bill:"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "HelveticaNeue-Thin", size: 35)!
        ]
        textView.attributedText         = NSAttributedString(string: text, attributes: attributes)
        textView.textAlignment          = .center
        textView.isEditable             = false
        textView.isScrollEnabled        = false
        textView.isSelectable           = false
//        textView.backgroundColor        = .gray
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder           = "$00.00"
        textField.textColor             = UIColor.black
        textField.font                  = UIFont.init(name: "HelveticaNeue-Thin", size: 60)
        textField.keyboardType          = UIKeyboardType.numberPad
        textField.textAlignment         = .center
        textField.borderStyle           = UITextField.BorderStyle.roundedRect
        textField.borderStyle           = UITextField.BorderStyle.none
        textField.sizeToFit()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let myTipTextView: UITextView = {
        let textView = UITextView()
        let text = "My Tip (15%):"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "HelveticaNeue-Thin", size: 30)!
        ]
        textView.attributedText         = NSAttributedString(string: text, attributes: attributes)
        textView.textAlignment          = .center
        textView.isEditable             = false
        textView.isScrollEnabled        = false
        textView.isSelectable           = false
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let totalTipAmount: UITextView = {
        let textView = UITextView()
        let text = "$0.00"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "HelveticaNeue-Thin", size: 60)!
        ]
        textView.attributedText         = NSAttributedString(string: text, attributes: attributes)
        textView.textAlignment          = .center
        textView.isEditable             = false
        textView.isScrollEnabled        = false
        textView.isSelectable           = false
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let tipSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        slider.setValue(15, animated: false)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.thumbTintColor = UIColor.gray
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let myTotalTextView: UITextView = {
        let textView = UITextView()
        let text = "Total:"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "HelveticaNeue-Thin", size: 30)!
        ]
        textView.attributedText         = NSAttributedString(string: text, attributes: attributes)
        textView.textAlignment          = .center
        textView.isEditable             = false
        textView.isScrollEnabled        = false
        textView.isSelectable           = false
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let myTotalAmount: UITextView = {
        let textView = UITextView()
        let text = "$0.00"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.init(name: "HelveticaNeue-Thin", size: 60)!
        ]
        textView.attributedText         = NSAttributedString(string: text, attributes: attributes)
        textView.textAlignment          = .center
        textView.isEditable             = false
        textView.isScrollEnabled        = false
        textView.isSelectable           = false
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        priceTextField.delegate = self
        priceTextField.placeholder = updatePrice()
        layoutSetup()
        tipSlider.setValue(15, animated: true)
        sliderSetup()
        addDoneButtonToKeyboard()
        tipSlider.addTarget(self, action: #selector(MainViewController.sliderChange), for: .valueChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let preText = textField.text as NSString?,
            preText.replacingCharacters(in: range, with: string).count <= 10 else {
                return false
        }

        if let digit = Int(string) {
            billAmount = billAmount * 10 + digit
            priceTextField.text = updatePrice()
        }
        if string == "" {
            billAmount = billAmount/10
            priceTextField.text = updatePrice()
        }
        return false
    }

    func updatePrice() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let amount = Double(billAmount/100) + Double(billAmount % 100) / 100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    func addDoneButtonToKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        priceTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        priceTextField.resignFirstResponder()
        print(priceTextField.text!)
    }
    
    @objc func sliderChange() {
        myTipTextView.text = "My Tip (\(Int(tipSlider.value.rounded()))%):"
        
        var priceStringText = String()
        var floatTipAmount = Float()
        var stringTipAmount = String()
        var floatTotalAmount = Float()
        
        if let priceOptionalStringText = self.priceTextField.text {
            priceStringText = String(priceOptionalStringText.dropFirst())
        }
        
        let floatPriceText = Float(priceStringText)
        
        if let priceText = floatPriceText {
            floatTipAmount = ((tipSlider.value.rounded() / 100) * priceText)
            stringTipAmount = "\(floatTipAmount.string(fractionDigits: 2))"
        }
        
        totalTipAmount.text = "$" + stringTipAmount
        
        if let totalAmountOne = Float(priceStringText) {
            if let totalAmountTwo = Float(stringTipAmount) {
                floatTotalAmount = totalAmountOne + totalAmountTwo
                
            }
        }

        myTotalAmount.text = "$" + "\(floatTotalAmount.string(fractionDigits: 2))"
        
//        if let priceText = floatPriceText {
//            totalTipAmount.text = "\((tipSlider.value / 100) * priceText)"
//        }
        
//        if let priceText = self.priceTextField.text {
//            if let price = Float(priceText) {
//                print("Slider x TipPrice = \(tipSlider.value * price)")
//                totalTipAmount.text = "\((tipSlider.value / 100) * price)"
//            } else {
//                print("\(priceText) is not convertible to Float.")
//            }
//        }
        
//        if let priceText = self.priceTextField.text {
//            guard let price = Float(priceText) else {
//                print("\(priceText) is not convertible to Float.")
//                return
//            }
//            let tip = Float(tipSlider.value)
//            totalTipAmount.text = "\((tip / 100) * price)"
//        }
    }
    
    private func sliderSetup() {
        view.addSubview(tipSlider)
        tipSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tipSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tipSlider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        tipSlider.anchorwithConstant(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 150, paddingTrailing: 150, width: 0, height: 0)
    }

    private func layoutSetup() {
        
        let leftContainerView = UIView()
        let rightContainerView = UIView()
        let leftTopHalfContainerView = UIView()
        let leftBottomHalfContainerView = UIView()
        view.addSubview(leftContainerView)
        view.addSubview(rightContainerView)
        leftContainerView.addSubview(leftTopHalfContainerView)
        leftContainerView.addSubview(leftBottomHalfContainerView)
        leftContainerView.translatesAutoresizingMaskIntoConstraints = false
        rightContainerView.translatesAutoresizingMaskIntoConstraints = false
        leftTopHalfContainerView.translatesAutoresizingMaskIntoConstraints = false
        leftBottomHalfContainerView.translatesAutoresizingMaskIntoConstraints = false
//        leftContainerView.backgroundColor = .gray
//        rightContainerView.backgroundColor = .orange
//        leftTopHalfContainerView.backgroundColor = .red
//        leftBottomHalfContainerView.backgroundColor = .blue
        
        leftTopHalfContainerView.addSubview(myBillTextView)
        myBillTextView.anchorwithConstant(top: leftTopHalfContainerView.topAnchor, bottom: nil, leading: leftTopHalfContainerView.leadingAnchor, trailing: nil, paddingTop: 150, paddingBottom: 0, paddingLeading: 20, paddingTrailing: 0, width: 0, height: 0)

        leftTopHalfContainerView.addSubview(priceTextField)
        priceTextField.anchorwithConstant(top: myBillTextView.bottomAnchor, bottom: nil, leading: leftTopHalfContainerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: 20, paddingTrailing: 0, width: 0, height: 0)

        leftTopHalfContainerView.addSubview(myTipTextView)
        myTipTextView.anchorwithConstant(top: nil, bottom: leftTopHalfContainerView.bottomAnchor, leading: nil, trailing: leftTopHalfContainerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        leftBottomHalfContainerView.addSubview(totalTipAmount)
        totalTipAmount.anchorwithConstant(top: leftBottomHalfContainerView.topAnchor, bottom: nil, leading: nil, trailing: leftBottomHalfContainerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
    
        leftBottomHalfContainerView.addSubview(myTotalTextView)
        myTotalTextView.anchorwithConstant(top: leftBottomHalfContainerView.topAnchor, bottom: nil, leading: leftBottomHalfContainerView.leadingAnchor, trailing: nil, paddingTop: 125, paddingBottom: 0, paddingLeading: 20, paddingTrailing: 0, width: 0, height: 0)
        
        leftBottomHalfContainerView.addSubview(myTotalAmount)
        myTotalAmount.anchorwithConstant(top: myTotalTextView.bottomAnchor, bottom: nil, leading: leftBottomHalfContainerView.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: 20, paddingTrailing: 0, width: 0, height: 0)
        
        // Container View Contraints
        
        leftTopHalfContainerView.heightAnchor.constraint(equalTo: leftContainerView.heightAnchor, multiplier: 0.5).isActive = true
        leftTopHalfContainerView.anchorwithConstant(top: leftContainerView.topAnchor, bottom: nil, leading: leftContainerView.leadingAnchor, trailing: leftContainerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        leftBottomHalfContainerView.heightAnchor.constraint(equalTo: leftContainerView.heightAnchor, multiplier: 0.5).isActive = true
        leftBottomHalfContainerView.anchorwithConstant(top: nil, bottom: leftContainerView.bottomAnchor, leading: leftContainerView.leadingAnchor, trailing: leftContainerView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        leftContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        leftContainerView.anchorwithConstant(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        rightContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        rightContainerView.anchorwithConstant(top: view.topAnchor, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
    }
    

}

