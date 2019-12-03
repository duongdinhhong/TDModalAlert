//
//  AOModalAlertView.swift
//  TDModalAlert
//
//  Created by Duong Dinh on 12/2/19.
//  Copyright © 2019 Duong Dinh. All rights reserved.
//
import UIKit

public class TDModalAlertView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    
    let nibName = "TDModalAlertView"
    var contentView: UIView!
    var timer: Timer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
}

// MARK: - Setup
extension TDModalAlertView {
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        headlineLabel.text = ""
        subheadLabel.text = ""
        contentView.alpha = 0.0
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    // Provide functions to update view
    public func set(image: UIImage) {
        self.statusImage.image = image
    }
    
     public func set(headline text: String) {
        self.headlineLabel.text = text
    }
    
    public func set(subheading text: String) {
        self.subheadLabel.text = text
    }
    
    public override func didMoveToSuperview() {
        // Fade in when added to superview
        // Then add a timer to remove the view
      self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
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
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}
