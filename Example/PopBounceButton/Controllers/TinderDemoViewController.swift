//
//  ViewController.swift
//  Demo
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import PopBounceButton

class TinderDemoViewController: UIViewController, ButtonStackViewDelegate {
    private let stackView = ButtonStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Tinder App"
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        stackView.delegate = self
        setupStackView()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingLeft: 24, paddingBottom: 12, paddingRight: 24)
    }

    func didTapButton(_ button: TinderButton) {
        switch button.tag {
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
