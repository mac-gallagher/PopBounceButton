//
//  ButtonStackView.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 11/17/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import PopBounceButton

protocol ButtonStackViewDelegate {
    func didTapButton(_ button: TinderButton)
}

class ButtonStackView: UIStackView {
    var delegate: ButtonStackViewDelegate?
    
    private let undoButton: TinderButton = {
        let button = TinderButton()
        button.setImage(UIImage(named: "undo"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let passButton: TinderButton = {
        let button = TinderButton()
        button.setImage(UIImage(named: "pass"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    private let superLikeButton: TinderButton = {
        let button = TinderButton()
        button.setImage(UIImage(named: "star"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    private let likeButton: TinderButton = {
        let button = TinderButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 4
        return button
    }()
    
    private let boostButton: TinderButton = {
        let button = TinderButton()
        button.setImage(UIImage(named: "lightning"), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.tag = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        distribution = .equalSpacing
        alignment = .center
        configureButtonStackView()
    }
    
    private func configureButtonStackView() {
        addArrangedSubview(undoButton)
        addArrangedSubview(passButton)
        addArrangedSubview(superLikeButton)
        addArrangedSubview(likeButton)
        addArrangedSubview(boostButton)
        layoutButtons()
    }
    
    private func layoutButtons() {
        let largeMultiplier: CGFloat = 66/414 //based on width of iPhone 8+
        let smallMultiplier: CGFloat = 54/414 //based on width of iPhone 8+
        layoutButton(undoButton, diameterMultiplier: smallMultiplier)
        layoutButton(passButton, diameterMultiplier: largeMultiplier)
        layoutButton(superLikeButton, diameterMultiplier: smallMultiplier)
        layoutButton(likeButton, diameterMultiplier: largeMultiplier)
        layoutButton(boostButton, diameterMultiplier: smallMultiplier)
    }
    
    private func layoutButton(_ button: PopBounceButton, diameterMultiplier: CGFloat) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: diameterMultiplier).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
    }
    
    @objc private func handleTap(_ button: TinderButton) {
        delegate?.didTapButton(button)
    }
}
