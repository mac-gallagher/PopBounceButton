//
//  AnimationViewController
//  Demo
//
//  Created by Mac Gallagher on 5/25/18.
//  Copyright © 2018 Mac Gallagher. All rights reserved.
//

import UIKit
import PopBounceButton

class AnimationViewController: UIViewController {
    
    let visibleButton = PopBounceButton()
    let initialButton = PopBounceButton()
    
    let bouncinessLabel = UILabel()
    let bouncinessSlider = UISlider()
    
    let speedLabel = UILabel()
    let speedSlider = UISlider()
    
    let velocityLabel = UILabel()
    let velocitySlider = UISlider()

    let cancelDurationLabel = UILabel()
    let cancelDurationSlider = UISlider()
    
    let scaleFactorLabel = UILabel()
    let scaleFactorSlider = UISlider()
    
    let scaleDurationLabel = UILabel()
    let scaleDurationSlider = UISlider()
    
    let minimumLongPressDurationLabel = UILabel()
    let minimumLongPressDurationSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Animation Demo"
        view.backgroundColor = UIColor(displayP3Red: 243/255, green: 245/255, blue: 248/255, alpha: 1)
        setupButton()
        setupLabels()
        setupSliders()
        handleReset()
        
        let resetButton = UIButton(type: .system)
        view.addSubview(resetButton)
        resetButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 50, height: 40)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
    }
    
    func setupButton() {
        visibleButton.backgroundColor = .orange
        view.addSubview(visibleButton)
        visibleButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        visibleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visibleButton.layer.cornerRadius = 60
    }
    
    func setupLabels() {
        view.addSubview(bouncinessLabel)
        bouncinessLabel.anchor(top: visibleButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        bouncinessLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(speedLabel)
        speedLabel.anchor(top: bouncinessLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        speedLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(velocityLabel)
        velocityLabel.anchor(top: speedLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        velocityLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(cancelDurationLabel)
        cancelDurationLabel.anchor(top: velocityLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        cancelDurationLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(scaleFactorLabel)
        scaleFactorLabel.anchor(top: cancelDurationLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        scaleFactorLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(scaleDurationLabel)
        scaleDurationLabel.anchor(top: scaleFactorLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        scaleDurationLabel.font = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(minimumLongPressDurationLabel)
        minimumLongPressDurationLabel.anchor(top: scaleDurationLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        minimumLongPressDurationLabel.font = UIFont.systemFont(ofSize: 15)
        
    }
    
    func setupSliders() {
        view.addSubview(bouncinessSlider)
        bouncinessSlider.anchor(top: visibleButton.bottomAnchor, left: bouncinessLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        bouncinessSlider.isContinuous = true
        bouncinessSlider.minimumValue = 0
        bouncinessSlider.maximumValue = 20
        bouncinessSlider.tag = 1
        bouncinessSlider.tintColor = UIColor.green
        bouncinessSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(speedSlider)
        speedSlider.anchor(top: bouncinessSlider.bottomAnchor, left: speedLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        speedSlider.isContinuous = true
        speedSlider.minimumValue = 0
        speedSlider.maximumValue = 20
        speedSlider.tag = 2
        speedSlider.tintColor = UIColor.green
        speedSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(velocitySlider)
        velocitySlider.anchor(top: speedSlider.bottomAnchor, left: velocityLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        velocitySlider.isContinuous = true
        velocitySlider.minimumValue = 0
        velocitySlider.maximumValue = 30
        velocitySlider.tag = 3
        velocitySlider.tintColor = UIColor.green
        velocitySlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(cancelDurationSlider)
        cancelDurationSlider.anchor(top: velocitySlider.bottomAnchor, left: cancelDurationLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        cancelDurationSlider.isContinuous = true
        cancelDurationSlider.minimumValue = 0
        cancelDurationSlider.maximumValue = 1
        cancelDurationSlider.tag = 4
        cancelDurationSlider.tintColor = UIColor.green
        cancelDurationSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(scaleFactorSlider)
        scaleFactorSlider.anchor(top: cancelDurationSlider.bottomAnchor, left: scaleFactorLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        scaleFactorSlider.isContinuous = true
        scaleFactorSlider.minimumValue = 0
        scaleFactorSlider.maximumValue = 1
        scaleFactorSlider.tag = 5
        scaleFactorSlider.tintColor = UIColor.green
        scaleFactorSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(scaleDurationSlider)
        scaleDurationSlider.anchor(top: scaleFactorSlider.bottomAnchor, left: scaleDurationLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        scaleDurationSlider.isContinuous = true
        scaleDurationSlider.minimumValue = 0
        scaleDurationSlider.maximumValue = 0.5
        scaleDurationSlider.tag = 6
        scaleDurationSlider.tintColor = UIColor.green
        scaleDurationSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        
        view.addSubview(minimumLongPressDurationSlider)
        minimumLongPressDurationSlider.anchor(top: scaleDurationSlider.bottomAnchor, left: minimumLongPressDurationLabel.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 40)
        minimumLongPressDurationSlider.isContinuous = true
        minimumLongPressDurationSlider.minimumValue = 0
        minimumLongPressDurationSlider.maximumValue = 1
        minimumLongPressDurationSlider.tag = 7
        minimumLongPressDurationSlider.tintColor = UIColor.green
        minimumLongPressDurationSlider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
    }
    
    @objc func handleReset() {
        
        visibleButton.removeAllAnimations()
        
        visibleButton.springBounciness = initialButton.springBounciness
        bouncinessSlider.setValue(Float(initialButton.springBounciness), animated: true)
        bouncinessLabel.text = "Bounciness = \(Int(initialButton.springBounciness))"
        
        visibleButton.springSpeed = initialButton.springSpeed
        speedSlider.setValue(Float(initialButton.springSpeed), animated: true)
        speedLabel.text = "Speed = \(Int(initialButton.springSpeed))"
        
        visibleButton.springVelocity = initialButton.springVelocity
        velocitySlider.setValue(Float(initialButton.springVelocity), animated: true)
        velocityLabel.text = "Velocity = \(Int(initialButton.springVelocity))"
        
        visibleButton.cancelDuration = initialButton.cancelDuration
        cancelDurationSlider.setValue(Float(initialButton.cancelDuration), animated: true)
        cancelDurationLabel.text = "Cancel Duration = " + String(format: "%.2f", visibleButton.cancelDuration) + " s"
        
        visibleButton.scaleFactor = initialButton.scaleFactor
        scaleFactorSlider.setValue(Float(initialButton.scaleFactor), animated: true)
        scaleFactorLabel.text = "Scale Factor = " + String(format: "%.1f", visibleButton.scaleFactor)
        
        visibleButton.scaleDuration = initialButton.scaleDuration
        scaleDurationSlider.setValue(Float(initialButton.scaleDuration), animated: true)
        scaleDurationLabel.text = "Scale Duration = " + String(format: "%.2f", visibleButton.scaleDuration) + " s"
        
        visibleButton.minimumPressDuration = initialButton.minimumPressDuration
        minimumLongPressDurationSlider.setValue(Float(initialButton.minimumPressDuration), animated: true)
        minimumLongPressDurationLabel.text = "Min Press Duration = " + String(format: "%.2f", visibleButton.minimumPressDuration) + " s"
        
    }
    
    @objc func handleSlider(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            visibleButton.springBounciness = CGFloat(sender.value.rounded(toPlaces: 0))
            bouncinessLabel.text = "Bounciness = \(Int(visibleButton.springBounciness))"
            initialButton.sendActions(for: .touchUpInside)
        case 2:
            visibleButton.springSpeed = CGFloat(sender.value.rounded(toPlaces: 0))
            speedLabel.text = "Speed = \(Int(visibleButton.springSpeed))"
        case 3:
            visibleButton.springVelocity = CGFloat(sender.value.rounded(toPlaces: 0))
            velocityLabel.text = "Velocity = \(Int(visibleButton.springVelocity))"
        case 4:
            visibleButton.cancelDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
            cancelDurationLabel.text = "Cancel Duration = " + String(format: "%.2f", visibleButton.cancelDuration) + " s"
        case 5:
            visibleButton.scaleFactor = CGFloat(sender.value.rounded(toPlaces: 1))
            scaleFactorLabel.text = "Scale Factor = " + String(format: "%.1f", visibleButton.scaleFactor)
        case 6:
            visibleButton.scaleDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
            scaleDurationLabel.text = "Scale Duration = " + String(format: "%.2f", visibleButton.scaleDuration) + " s"
        case 7:
            visibleButton.minimumPressDuration = TimeInterval(sender.value.rounded(toPlaces: 2))
            minimumLongPressDurationLabel.text = "Min Press Duration = " + String(format: "%.2f", visibleButton.minimumPressDuration) + " s"
        default:
            break
        }
    }
    
}

extension Float {
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
