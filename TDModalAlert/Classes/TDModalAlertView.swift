//
//  AOModalAlertView.swift
//  TDModalAlert
//
//  Created by Duong Dinh on 12/2/19.
//  Copyright © 2019 Duong Dinh. All rights reserved.
//
import UIKit

public class TDModalAlertView: UIView {
    
    // MARK: - Views
    lazy var visualEffectView: UIVisualEffectView = {
        let visualEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let visualEffectView = UIVisualEffectView(effect: visualEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.layer.cornerRadius = 5
        visualEffectView.layer.masksToBounds = true
        
        return visualEffectView
    }()
    
    // MARK: - Container view
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    /// Content view
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    /// Status image view
    lazy var statusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        
        if let imagePath = Bundle.init(for: TDModalAlertView.self).path(forResource: "ic_success", ofType: "png") {
            imageView.image = UIImage(contentsOfFile: imagePath)
        }
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    /// Headline label
    lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    /// Message label
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Properties
    private var timer: Timer?
}

// MARK: - Life Cycle
extension TDModalAlertView {
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUpView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            DispatchQueue.main.async {
                self.show()
            }
        }
    }
}

// MARK: - Setup
extension TDModalAlertView {
    
    private func setUpView() {
        setUpContainerView()
        setUpVisualEffectView()
        setUpContentView()
        setUpImageView()
        setUpHeadlineLabel()
        setUpMessageLabel()
    }
    
    private func setUpContainerView() {
        addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setUpVisualEffectView() {
        containerView.addSubview(visualEffectView)
        
        visualEffectView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        visualEffectView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        visualEffectView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        visualEffectView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    private func setUpContentView() {
        visualEffectView.contentView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: visualEffectView.contentView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: visualEffectView.contentView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: visualEffectView.contentView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: visualEffectView.contentView.bottomAnchor).isActive = true
    }
    
    private func setUpImageView() {
        contentView.addSubview(statusImage)
        
        statusImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        statusImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        statusImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setUpHeadlineLabel() {
        contentView.addSubview(headlineLabel)
        
        headlineLabel.topAnchor.constraint(equalTo: statusImage.bottomAnchor, constant: 10).isActive = true
        headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headlineLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setUpMessageLabel() {
        contentView.addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}

// MARK: - Actions
extension TDModalAlertView {
    
    private func show() {
        containerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.containerView.alpha = 1.0
            self.containerView.transform = CGAffineTransform.identity
        }) { _ in
            self.timer = Timer.scheduledTimer(
                timeInterval: TimeInterval(3.0),
                target: self,
                selector: #selector(self.removeSelf),
                userInfo: nil,
                repeats: false)
        }
    }
    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(
            withDuration: 0.15,
            animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.containerView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

// MARK: - Public APIs
extension TDModalAlertView {
    
    public func set(image: UIImage) {
        self.statusImage.image = image
    }
    
     public func set(headline text: String) {
        self.headlineLabel.text = text
    }
    
    public func set(message text: String) {
        self.messageLabel.text = text
    }
}
