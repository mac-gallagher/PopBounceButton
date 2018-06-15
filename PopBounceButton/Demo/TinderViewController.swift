//
//  ViewController.swift
//  Demo
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
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
        undoButton.tag = 1
        configureButton(button: undoButton, diameter: smallDiameter)
        stackView.addArrangedSubview(undoButton)
        
        let passButton = PopBounceButton()
        passButton.setImage(#imageLiteral(resourceName: "pass"))
        passButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        passButton.tag = 2
        configureButton(button: passButton, diameter: largeDiameter)
        stackView.addArrangedSubview(passButton)
        
        let superLikeButton = PopBounceButton()
        superLikeButton.setImage(#imageLiteral(resourceName: "star"))
        superLikeButton.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        superLikeButton.tag = 3
        configureButton(button: superLikeButton, diameter: smallDiameter)
        stackView.addArrangedSubview(superLikeButton)
        
        let likeButton = PopBounceButton()
        likeButton.setImage(#imageLiteral(resourceName: "heart"))
        likeButton.tag = 4
        likeButton.imageEdgeInsets = UIEdgeInsets(top: 15, left: 14, bottom: 13, right: 14)
        
        configureButton(button: likeButton, diameter: largeDiameter)
        stackView.addArrangedSubview(likeButton)
        
        let boostButton = PopBounceButton()
        boostButton.setImage(#imageLiteral(resourceName: "lightning"))
        boostButton.imageEdgeInsets = UIEdgeInsets(top: 13, left: 12, bottom: 11, right: 12)
        boostButton.tag = 5
        configureButton(button: boostButton, diameter: smallDiameter)
        stackView.addArrangedSubview(boostButton)
    }
    
    func configureButton(button: PopBounceButton, diameter: CGFloat) {
        button.layer.cornerRadius = diameter / 2
        button.setShadow(radius: 0.2 * diameter, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * diameter))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: diameter).isActive = true
        button.heightAnchor.constraint(equalToConstant: diameter).isActive = true
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc func handleTap(_ sender: PopBounceButton) {
        switch sender.tag {
        case 1:
            print("Undo")
        case 2:
            print("Pass")
        case 3:
            print("Super like")
        case 4:
            print("Like")
        case 5:
            print("Boost")
        default:
            break
        }
    }
    
    
    
    
    
}







