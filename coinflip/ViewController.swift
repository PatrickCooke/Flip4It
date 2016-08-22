//
//  ViewController.swift
//  coinflip
//
//  Created by Patrick Cooke on 8/19/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let container = UIView()
    let headsSquare = UIImageView()
    let tailsSquare = UIImageView()
    let actionButton = UIButton()
    let results = UILabel()
    let coinFaces = Coin()
    
    //MARK: - Create Assets
    
    func createButton() {
        //No longer needed, added a guesture method which responds to a tap anywhere on screen
        
        let width = self.view.bounds.width
        let buttonY =  self.view.bounds.height - 50
        self.actionButton.frame = CGRect(x: 0, y: buttonY, width: width, height: 44)
        self.actionButton.backgroundColor = UIColor.blueColor()
        self.actionButton.titleLabel?.textColor = UIColor.whiteColor()
        self.actionButton.setTitle("Flip", forState: .Normal)
        self.actionButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.actionButton.layer.cornerRadius = 5.0
        self.actionButton.addTarget(self, action: #selector(animateButtonTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(actionButton)
        
    }
    
    func createframes() {
        let width = self.view.bounds.width
        let height = self.view.bounds.height - 40
        self.container.frame = CGRect(x: 0, y: 0, width: width, height: height)
        container.backgroundColor = UIColor.clearColor()
        self.view.addSubview(container)
        
        
        let resulty = self.container.frame.height
        self.results.frame = CGRect(x: 0, y: resulty, width: width, height: 40)
        results.textAlignment = .Center
        
        results.font.fontWithSize(30)
        results.text = "Shake or Tap to Flip the Coin"
        self.view.addSubview(results)
        
        let x = self.container.center.x - 150
        let y = self.container.center.y - 150
        self.headsSquare.frame = CGRect(x: x, y: y, width: 300, height: 300)
        self.tailsSquare.frame = headsSquare.frame
        if coinFaces.coinFront == nil {
            self.headsSquare.image = UIImage(named: "quarterFront")
            self.tailsSquare.image = UIImage(named: "quarterBack")
        } else {
            self.headsSquare.image = UIImage(named: coinFaces.coinFront!)
            self.tailsSquare.image = UIImage(named: coinFaces.coinBack!)
        }
        
        
        print("generated \(coinFaces.coinFront)")
        self.container.addSubview(self.headsSquare)
    }
    
    //MARK: - Shake for Flip method
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        self.animateButtonTapped()
    }
    
    //MARK: - Tap for flip Method
    
    func tapGesture() {
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(animateButtonTapped))
        view.addGestureRecognizer(screenTap)
    }
    
    //MARK: - Flip Coin Method
    
    @IBAction func animateButtonTapped() {
        let RandNumb = drand48()
        let totalFlips = Int(RandNumb * 10)
        
        for flipCount in 0...totalFlips {
            print("flip #\(flipCount)")
            animate()
        }
        if ((self.headsSquare.superview) != nil) {
            print("heads!")
            self.results.text = "Heads!"
        } else {
            print("tails")
            self.results.text = "Tails!"
        }
    }
    
    func animate() {
        var views : (frontView: UIView, backView: UIView)
        if((self.headsSquare.superview) != nil){
            views = (frontView: self.headsSquare, backView: self.tailsSquare)
        }
        else {
            views = (frontView: self.tailsSquare, backView: self.headsSquare)
        }
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
        UIView.transitionFromView(views.frontView, toView: views.backView, duration: 0.2, options: transitionOptions, completion:nil)
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createframes()
        //createButton() - No longer needed
        tapGesture()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(createframes), name: "coin", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

