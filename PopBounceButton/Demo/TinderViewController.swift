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
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .equalSpacing
        sv.alignment = .center
        return sv
    }()
    
    let undoButton: PopBounceButton = {
        let button = PopBounceButton()
        button.setImage(#imageLiteral(resourceName: "undo"))
        button.tag = 1
        return button
    }()
    
    let passButton: PopBounceButton = {
        let button = PopBounceButton()
        button.setImage(#imageLiteral(resourceName: "pass"))
        button.tag = 2
        return button
    }()
    
    let superLikeButton: PopBounceButton = {
        let button = PopBounceButton()
        button.setImage(#imageLiteral(resourceName: "star"))
        button.tag = 3
        return button
    }()
    
    let likeButton: PopBounceButton = {
        let button = PopBounceButton()
        button.setImage(#imageLiteral(resourceName: "heart"))
        button.tag = 4
        return button
    }()
    
    let boostButton: PopBounceButton = {
        let button = PopBounceButton()
        button.setImage(#imageLiteral(resourceName: "lightning"))
        button.tag = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinder App"
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        setupButtons()
        setupStackView()
    }
    
    func setupButtons() {
        let largeDiameter: CGFloat = 66 * (view.bounds.width / 414) //based on iPhone 8+
        let smallDiameter: CGFloat = 54 * (view.bounds.width / 414)
        configureButton(button: undoButton, diameter: smallDiameter)
        configureButton(button: passButton, diameter: largeDiameter)
        configureButton(button: superLikeButton, diameter: smallDiameter)
        configureButton(button: likeButton, diameter: largeDiameter)
        configureButton(button: boostButton, diameter: smallDiameter)
    }
    
    func configureButton(button: PopBounceButton, diameter: CGFloat) {
        button.layer.cornerRadius = diameter / 2
        button.setShadow(radius: 0.2 * diameter, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * diameter))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: diameter).isActive = true
        button.heightAnchor.constraint(equalToConstant: diameter).isActive = true
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 24, paddingBottom: 13, paddingRight: 24)
        stackView.addArrangedSubview(undoButton)
        stackView.addArrangedSubview(passButton)
        stackView.addArrangedSubview(superLikeButton)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(boostButton)
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







