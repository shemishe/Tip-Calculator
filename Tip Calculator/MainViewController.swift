//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Sherman Shi on 4/16/19.
//  Copyright © 2019 Sherman Shi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
        textView.backgroundColor        = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder           = "$00.00"
        textField.textColor             = UIColor.black
        textField.font                  = UIFont.init(name: "HelveticaNeue-Thin", size: 70)
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
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 250, height: 20))
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
        layoutSetup()
        sliderSetup()
        addDoneButtonToKeyboard()
        tipSlider.addTarget(self, action: #selector(MainViewController.sliderChange), for: .valueChanged)
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
    }
    
    @objc func sliderChange() {
        myTipTextView.text = "My Tip (\(Int(tipSlider.value.rounded()))%):"
    }
    
    private func sliderSetup() {
        view.addSubview(tipSlider)
        tipSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tipSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tipSlider.anchorwithConstant(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 160, paddingTrailing: 160, width: 0, height: 0)
    }

    private func layoutSetup() {
        
        let topHalfContainerView = UIView()
        let bottomHalfContainerView = UIView()
        view.addSubview(topHalfContainerView)
        view.addSubview(bottomHalfContainerView)
        topHalfContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomHalfContainerView.translatesAutoresizingMaskIntoConstraints = false
//        topHalfContainerView.backgroundColor = .gray
//        bottomHalfContainerView.backgroundColor = .orange
        
        topHalfContainerView.addSubview(myBillTextView)
        myBillTextView.centerXAnchor.constraint(equalTo: topHalfContainerView.centerXAnchor).isActive = true
        myBillTextView.centerYAnchor.constraint(equalTo: topHalfContainerView.centerYAnchor).isActive = true
        
        topHalfContainerView.addSubview(priceTextField)
        priceTextField.centerXAnchor.constraint(equalTo: topHalfContainerView.centerXAnchor).isActive = true
        priceTextField.anchorwithConstant(top: myBillTextView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        topHalfContainerView.addSubview(myTipTextView)
        myTipTextView.centerXAnchor.constraint(equalTo: topHalfContainerView.centerXAnchor).isActive = true
        myTipTextView.anchorwithConstant(top: priceTextField.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        view.addSubview(totalTipAmount)
        totalTipAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalTipAmount.anchorwithConstant(top: myTipTextView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        view.addSubview(myTotalTextView)
        myTotalTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTotalTextView.anchorwithConstant(top: totalTipAmount.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        view.addSubview(myTotalAmount)
        myTotalAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTotalAmount.anchorwithConstant(top: myTotalTextView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        
        topHalfContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topHalfContainerView.anchorwithConstant(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
        bottomHalfContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        bottomHalfContainerView.anchorwithConstant(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
    }
    

}

