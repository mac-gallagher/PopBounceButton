//
//  ViewController.swift
//  Demo
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import pop
import PopBounceButton

class TinderViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinder App"
        view.backgroundColor = UIColor(displayP3Red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        setupStackView()
    }
    
    func setupStackView() {
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let largeDiameter: CGFloat = 66
        let smallDiameter: CGFloat = 54
        
        let undoButton = PopBounceButton()
        undoButton.setImage(#imageLiteral(resourceName: "undo"))
        undoButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        configureButton(button: undoButton, diameter: smallDiameter)
        stackView.addArrangedSubview(undoButton)
        
        let passButton = PopBounceButton()
        passButton.setImage(#imageLiteral(resourceName: "pass"))
        passButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        configureButton(button: passButton, diameter: largeDiameter)
        stackView.addArrangedSubview(passButton)
        
        let starButton = PopBounceButton()
        starButton.setImage(#imageLiteral(resourceName: "star"))
        starButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        configureButton(button: starButton, diameter: smallDiameter)
        stackView.addArrangedSubview(starButton)
        
        let heartButton = PopBounceButton()
        heartButton.setImage(#imageLiteral(resourceName: "heart"))
        heartButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 14, bottom: 13, right: 14)
        configureButton(button: heartButton, diameter: largeDiameter)
        stackView.addArrangedSubview(heartButton)
        
        let boostButton = PopBounceButton()
        boostButton.setImage(#imageLiteral(resourceName: "lightning"))
        boostButton.imageEdgeInsets = UIEdgeInsets(top: 13, left: 12, bottom: 11, right: 12)
        configureButton(button: boostButton, diameter: smallDiameter)
        stackView.addArrangedSubview(boostButton)
    }
    
    func configureButton(button: PopBounceButton, diameter: CGFloat) {
        button.layer.cornerRadius = diameter / 2
        button.setShadow(radius: 0.2 * diameter, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * diameter))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: diameter).isActive = true
        button.heightAnchor.constraint(equalToConstant: diameter).isActive = true
    }
    
    
}





