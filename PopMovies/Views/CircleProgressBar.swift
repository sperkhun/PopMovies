//
//  CircleProgressBar.swift
//  PopMovies
//
//  Created by Serhii PERKHUN on 2/23/19.
//  Copyright © 2019 Serhii PERKHUN. All rights reserved.
//

import UIKit

class CircleProgressBar: UIView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    
    public var progress: Double = 0.0 {
        didSet {
            label.text = String(progress)
            switch progress {
            case _ where progress >= 7.0:
                self.progressColor = UIColor(red:0.39, green:0.80, blue:0.51, alpha:0.5).cgColor
            case _ where progress >= 4.0:
                self.progressColor = UIColor(red:0.82, green:0.84, blue:0.33, alpha:0.5).cgColor
            default:
                self.progressColor = UIColor(red:0.79, green:0.22, blue:0.38, alpha:0.5).cgColor
            }
        }
    }

    
    public var lineWidth:CGFloat = 10 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth
        }
    }
    
    
    public var labelSize: CGFloat = 20 {
        didSet {
            label.font = UIFont(name: "AvenirNext-DemiBold", size: labelSize)
            label.textColor = UIColor.white
            configLabel()
        }
    }
    
    
    public func setProgress(withAnimation: Bool) {
        
        let progress = self.progress / 10
        
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = 1.5
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
            
        }
        self.configLabel()
    }
    
    
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var progressColor = UIColor.lightGray.cgColor
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth - 10)/2 }
            else { return (self.frame.height - lineWidth - 10)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        
        self.backgroundLayer.strokeColor = progressColor
        self.backgroundLayer.lineWidth = lineWidth
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = kCALineCapRound
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = progressColor.copy(alpha: 1.0)
        foregroundLayer.strokeEnd = CGFloat(progress / 10)
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
    }
    
    
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }

}
