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
    
    //MARK: - Subviews
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let button: PopBounceButton = {
        let button = PopBounceButton(type: UIButton.ButtonType.roundedRect)
        button.backgroundColor = .orange
        button.layer.masksToBounds = true
        return button
    }()
    
    let defaultButton = PopBounceButton() //for initial settings
    
    //MARK: Labels
    
    let bouncinessLabel = ResizingLabel()
    let speedLabel = ResizingLabel()
    let velocityLabel = ResizingLabel()
    let cancelDurationLabel = ResizingLabel()
    let scaleFactorLabel = ResizingLabel()
    let scaleDurationLabel = ResizingLabel()
    let minimumLongPressDurationLabel = ResizingLabel()
    
    //MARK: Sliders
    
    lazy var bouncinessSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 20)
        slider.tag = 1
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var speedSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 20)
        slider.tag = 2
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var velocitySlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 30)
        slider.tag = 3
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var cancelDurationSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 1)
        slider.tag = 4
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var scaleFactorSlider: Slider = {
        let slider = Slider(minimumValue: 0.5, maximumValue: 1)
        slider.tag = 5
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var scaleDurationSlider: Slider = {
        let slider = Slider(minimumValue: 0, maximumValue: 0.5)
        slider.tag = 6
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var minimumLongPressDurationSlider: Slider = {
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
    
    func layoutSubviews() {
        view.addSubview(resetButton)
        resetButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        layoutBounceButton()
        layoutStackView()
    }
    
    func layoutBounceButton() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: resetButton.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func layoutStackView() {
        let minimumSpacing: CGFloat = 10

        let bouncinessStackView = horizontalStackView(subviews: [bouncinessLabel, bouncinessSlider], spacing: minimumSpacing)
        let speedStackView = horizontalStackView(subviews: [speedLabel, speedSlider], spacing: minimumSpacing)
        let velocityStackView = horizontalStackView(subviews: [velocityLabel, velocitySlider], spacing: minimumSpacing)
        let cancelDurationStackView = horizontalStackView(subviews: [cancelDurationLabel, cancelDurationSlider], spacing: minimumSpacing)
        let scaleFactorStackView = horizontalStackView(subviews: [scaleFactorLabel, scaleFactorSlider], spacing: minimumSpacing)
        let scaleDurationStackView = horizontalStackView(subviews: [scaleDurationLabel, scaleDurationSlider], spacing: minimumSpacing)
        let minimumLongPressDurationStackView = horizontalStackView(subviews: [minimumLongPressDurationLabel, minimumLongPressDurationSlider], spacing: minimumSpacing)
        
        view.addSubview(stackView)
        stackView.anchor(top: button.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(bouncinessStackView)
        stackView.addArrangedSubview(speedStackView)
        stackView.addArrangedSubview(velocityStackView)
        stackView.addArrangedSubview(cancelDurationStackView)
        stackView.addArrangedSubview(scaleFactorStackView)
        stackView.addArrangedSubview(scaleDurationStackView)
        stackView.addArrangedSubview(minimumLongPressDurationStackView)
    }
    
    func horizontalStackView(subviews: [UIView], spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = spacing
        for subview in subviews {
            stack.addArrangedSubview(subview)
        }
        return stack
    }
    
    override func viewDidLayoutSubviews() {
        button.layer.cornerRadius = button.bounds.width / 2
    }
    
    //MARK: Button/Slider Handling
    
    @objc func reset() {
//        button.removeAllAnimations()
        button.springBounciness = defaultButton.springBounciness
        button.springSpeed = defaultButton.springSpeed
        button.springVelocity = defaultButton.springVelocity
        button.cancelDuration = defaultButton.cancelDuration
        button.longPressScaleFactor = defaultButton.longPressScaleFactor
        button.longPressScaleDuration = defaultButton.longPressScaleDuration
        button.minimumPressDuration = defaultButton.minimumPressDuration
        
        updateLabels()
        updateSliders()
    }
    
    func updateLabels() {
        bouncinessLabel.text = "Bounciness = \(Int(button.springBounciness))"
        speedLabel.text = "Speed = \(Int(button.springSpeed))"
        velocityLabel.text = "Velocity = \(Int(button.springVelocity))"
        cancelDurationLabel.text = "Cancel Duration = " + String(format: "%.2f", button.cancelDuration) + " s"
        scaleFactorLabel.text = "Scale Factor = " + String(format: "%.2f", button.longPressScaleFactor)
        scaleDurationLabel.text = "Scale Duration = " + String(format: "%.2f", button.longPressScaleDuration) + " s"
        minimumLongPressDurationLabel.text = "Min Press Duration = " + String(format: "%.2f", button.minimumPressDuration) + " s"
    }
    
    func updateSliders() {
        bouncinessSlider.setValue(Float(button.springBounciness), animated: true)
        speedSlider.setValue(Float(button.springSpeed), animated: true)
        velocitySlider.setValue(Float(button.springVelocity), animated: true)
        cancelDurationSlider.setValue(Float(button.cancelDuration), animated: true)
        scaleFactorSlider.setValue(Float(button.longPressScaleFactor), animated: true)
        scaleDurationSlider.setValue(Float(button.longPressScaleDuration), animated: true)
        minimumLongPressDurationSlider.setValue(Float(button.minimumPressDuration), animated: true)
    }
    
    @objc func handleSlider(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            button.springBounciness = CGFloat(sender.value.rounded(toPlaces: 0))
        case 2:
            button.springSpeed = CGFloat(sender.value.rounded(toPlaces: 0))
        case 3:
            button.springVelocity = CGFloat(sender.value.rounded(toPlaces: 0))
        case 4:
            button.cancelDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        case 5:
            button.longPressScaleFactor = CGFloat(sender.value.rounded(toPlaces: 2))
        case 6:
            button.longPressScaleDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        case 7:
            button.minimumPressDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
        default:
            break
        }
        updateLabels()
        updateSliders()
    }
}
