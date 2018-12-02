//
//  MessageDemoViewController.swift
//  PopBounceButton_Example
//
//  Created by Mac Gallagher on 12/1/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import PopBounceButton

class MessageDemoViewController: UIViewController {
    private let messageButton = MessageButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Message Button Demo"
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        
        let buttonContainer = UIView()
        buttonContainer.addSubview(messageButton)
        messageButton.anchorToSuperview()
        view.addSubview(buttonContainer)
        buttonContainer.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 30, width: 200, height: 50)
        buttonContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonContainer.applyShadow(radius: 5, opacity: 0.3, offset: CGSize(width: 0, height: 3))
    }
}
