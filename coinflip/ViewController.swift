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
    let coinFaces = Coin.sharedInstance
    
    //MARK: - Create Assets
    
    func createframes() {
    //create coin container
        let width = self.view.bounds.width
        let height = self.view.bounds.height - 40
        self.container.frame = CGRect(x: 0, y: 0, width: width, height: height)
        container.backgroundColor = UIColor.clearColor()
        self.view.addSubview(container)
        
    //create coin
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
            coinFaces.coinFront = "quarterFront"
            coinFaces.coinBack = "quarterBack"
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
    
    var totalFlips = 1
    var flipCount = 0
    
    @IBAction func animateButtonTapped() {
        flipCount = 0
        let RandNumb = drand48()
        totalFlips = Int(RandNumb * 10)
        print("Flip Count \(totalFlips)")
        animate()
    }
    
    func animate() {
        if flipCount <= totalFlips {
            flipCount += 1
            var views : (frontView: UIView, backView: UIView)
            if((self.headsSquare.superview) != nil){
                views = (frontView: self.headsSquare, backView: self.tailsSquare)
            }
            else {
                views = (frontView: self.tailsSquare, backView: self.headsSquare)
            }
            let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
            UIView.transitionFromView(views.frontView, toView: views.backView, duration: 0.2, options: transitionOptions, completion: { (complete) in
                print("Loop \(self.flipCount)")
                self.animate()
            })
        }
    }
    
    //MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        createframes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

