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
    
    //MARK: - Subviews
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.distribution = .equalSpacing
        sv.alignment = .center
        return sv
    }()
    
    lazy var undoButton: PopBounceButton = {
        let button = PopBounceButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "undo"))
        button.tag = 1
        return button
    }()
    
    lazy var passButton: PopBounceButton = {
        let button = PopBounceButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "pass"))
        button.tag = 2
        return button
    }()
    
    lazy var superLikeButton: PopBounceButton = {
        let button = PopBounceButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "star"))
        button.tag = 3
        return button
    }()
    
    lazy var likeButton: PopBounceButton = {
        let button = PopBounceButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "heart"))
        button.tag = 4
        return button
    }()
    
    lazy var boostButton: PopBounceButton = {
        let button = PopBounceButton()
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "lightning"))
        button.tag = 5
        return button
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinder App"
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        setupStackView()
        setupButtons()
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)
        stackView.addArrangedSubview(undoButton)
        stackView.addArrangedSubview(passButton)
        stackView.addArrangedSubview(superLikeButton)
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(boostButton)
    }
    
    func setupButtons() {
        let largeMultiplier: CGFloat = 66/414 //based on width of iPhone 8+
        let smallMultiplier: CGFloat = 54/414 //based on width of iPhone 8+
        layoutButton(button: undoButton, diameterMultiplier: smallMultiplier)
        layoutButton(button: passButton, diameterMultiplier: largeMultiplier)
        layoutButton(button: superLikeButton, diameterMultiplier: smallMultiplier)
        layoutButton(button: likeButton, diameterMultiplier: largeMultiplier)
        layoutButton(button: boostButton, diameterMultiplier: smallMultiplier)
    }
    
    func layoutButton(button: PopBounceButton, diameterMultiplier: CGFloat) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: diameterMultiplier).isActive = true
        button.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: diameterMultiplier).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        for button in stackView.subviews as! [PopBounceButton] {
            let diameter = button.bounds.width
            button.layer.cornerRadius = diameter / 2
            button.setShadow(radius: 0.2 * diameter, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * diameter))
        }
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







