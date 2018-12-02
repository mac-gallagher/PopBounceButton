//
//  AnimationViewController
//  Demo
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import PopBounceButton

class AnimationDemoViewController: UIViewController {
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let bounceButton: PopBounceButton = {
        let button = PopBounceButton(type: UIButton.ButtonType.roundedRect)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        return button
    }()
    
    private let defaultButton = PopBounceButton() //for initial settings
    
    private let bouncinessLabel = ResizingLabel()
    private let speedLabel = ResizingLabel()
    private let velocityLabel = ResizingLabel()
    private let cancelDurationLabel = ResizingLabel()
    private let scaleFactorLabel = ResizingLabel()
    private let scaleDurationLabel = ResizingLabel()
    private let minimumLongPressDurationLabel = ResizingLabel()
    
    private lazy var bouncinessSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 20)
        slider.tag = 1
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var speedSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 20)
        slider.tag = 2
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var velocitySlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 30)
        slider.tag = 3
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var cancelDurationSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 1)
        slider.tag = 4
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var scaleFactorSlider: Slider = {
        let slider = Slider(minimumValue: 0.5, maximumValue: 1)
        slider.tag = 5
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var scaleDurationSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 0.5)
        slider.tag = 6
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var minimumLongPressDurationSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 1)
        slider.tag = 7
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    //MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Animation Demo"
        view.backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        additionalSafeAreaInsets = UIEdgeInsets(top: 2, left: 10, bottom: 10, right: 10)
        layoutSubviews()
        reset()
    }
    
    //MARK: - Layout
    
    private func layoutSubviews() {
        view.addSubview(resetButton)
        resetButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor)
        layoutBounceButton()
        layoutStackView()
    }
    
    private func layoutBounceButton() {
        view.addSubview(bounceButton)
        bounceButton.translatesAutoresizingMaskIntoConstraints = false
        bounceButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        bounceButton.widthAnchor.constraint(equalTo: bounceButton.heightAnchor).isActive = true
        bounceButton.topAnchor.constraint(equalTo: resetButton.bottomAnchor).isActive = true
        bounceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func layoutStackView() {
        let minimumSpacing: CGFloat = 10

        let bouncinessStackView = horizontalStackView(subviews: [bouncinessLabel, bouncinessSlider], spacing: minimumSpacing)
        let speedStackView = horizontalStackView(subviews: [speedLabel, speedSlider], spacing: minimumSpacing)
        let velocityStackView = horizontalStackView(subviews: [velocityLabel, velocitySlider], spacing: minimumSpacing)
        let cancelDurationStackView = horizontalStackView(subviews: [cancelDurationLabel, cancelDurationSlider], spacing: minimumSpacing)
        let scaleFactorStackView = horizontalStackView(subviews: [scaleFactorLabel, scaleFactorSlider], spacing: minimumSpacing)
        let scaleDurationStackView = horizontalStackView(subviews: [scaleDurationLabel, scaleDurationSlider], spacing: minimumSpacing)
        let minimumLongPressDurationStackView = horizontalStackView(subviews: [minimumLongPressDurationLabel, minimumLongPressDurationSlider], spacing: minimumSpacing)
        
        view.addSubview(stackView)
        stackView.anchor(top: bounceButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(bouncinessStackView)
        stackView.addArrangedSubview(speedStackView)
        stackView.addArrangedSubview(velocityStackView)
        stackView.addArrangedSubview(cancelDurationStackView)
        stackView.addArrangedSubview(scaleFactorStackView)
        stackView.addArrangedSubview(scaleDurationStackView)
        stackView.addArrangedSubview(minimumLongPressDurationStackView)
    }
    
    private func horizontalStackView(subviews: [UIView], spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = spacing
        for subview in subviews {
            stack.addArrangedSubview(subview)
        }
        return stack
    }
    
    override func viewDidLayoutSubviews() {
        bounceButton.layer.cornerRadius = bounceButton.bounds.width / 2
    }
    
    //MARK: - Slider Handling
    
    @objc func reset() {
        bounceButton.springBounciness = defaultButton.springBounciness
        bounceButton.springSpeed = defaultButton.springSpeed
        bounceButton.springVelocity = defaultButton.springVelocity
        bounceButton.cancelTapScaleDuration = defaultButton.cancelTapScaleDuration
        bounceButton.longPressScaleFactor = defaultButton.longPressScaleFactor
        bounceButton.longPressScaleDuration = defaultButton.longPressScaleDuration
        bounceButton.minimumPressDuration = defaultButton.minimumPressDuration
        
        updateLabels()
        updateSliders()
    }
    
    private func updateLabels() {
        bouncinessLabel.text = "Bounciness = \(Int(bounceButton.springBounciness))"
        speedLabel.text = "Speed = \(Int(bounceButton.springSpeed))"
        velocityLabel.text = "Velocity = \(Int(bounceButton.springVelocity))"
        cancelDurationLabel.text = "Cancel Duration = " + String(format: "%.2f", bounceButton.cancelTapScaleDuration) + " s"
        scaleFactorLabel.text = "Scale Factor = " + String(format: "%.2f", bounceButton.longPressScaleFactor)
        scaleDurationLabel.text = "Scale Duration = " + String(format: "%.2f", bounceButton.longPressScaleDuration) + " s"
        minimumLongPressDurationLabel.text = "Min Press Duration = " + String(format: "%.2f", bounceButton.minimumPressDuration) + " s"
    }
    
    private func updateSliders() {
        bouncinessSlider.setValue(Float(bounceButton.springBounciness), animated: true)
        speedSlider.setValue(Float(bounceButton.springSpeed), animated: true)
        velocitySlider.setValue(Float(bounceButton.springVelocity), animated: true)
        cancelDurationSlider.setValue(Float(bounceButton.cancelTapScaleDuration), animated: true)
        scaleFactorSlider.setValue(Float(bounceButton.longPressScaleFactor), animated: true)
        scaleDurationSlider.setValue(Float(bounceButton.longPressScaleDuration), animated: true)
        minimumLongPressDurationSlider.setValue(Float(bounceButton.minimumPressDuration), animated: true)
    }
    
    @objc private func handleSlider(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            bounceButton.springBounciness = CGFloat(sender.value.rounded(toPlaces: 0))
        case 2:
            bounceButton.springSpeed = CGFloat(sender.value.rounded(toPlaces: 0))
        case 3:
            bounceButton.springVelocity = CGFloat(sender.value.rounded(toPlaces: 0))
        case 4:
            bounceButton.cancelTapScaleDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        case 5:
            bounceButton.longPressScaleFactor = CGFloat(sender.value.rounded(toPlaces: 2))
        case 6:
            bounceButton.longPressScaleDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        case 7:
            bounceButton.minimumPressDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        default:
            break
        }
        updateLabels()
        updateSliders()
    }
}
