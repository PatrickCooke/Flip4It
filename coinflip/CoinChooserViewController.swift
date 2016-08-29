//
//  CoinChooserViewController.swift
//  coinflip
//
//  Created by Patrick Cooke on 8/22/16.
//  Copyright © 2016 Patrick Cooke. All rights reserved.
//

import UIKit

class CoinChooserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    static let sharedInstance = CoinChooserViewController()
    var coinFront: String!
    var coinBack: String!
    let coinFaces = Coin.sharedInstance
    let VC = ViewController()
    let coinArray = ["Penny", "Nickel", "Dime", "Quarter", "Half Dollar"]
    let coinFrontImageArray = ["pennyFront", "nickelFront", "dimeFront", "quarterFront", "halfdollarFront"]
    let coinBackImageArray = ["pennyBack", "nickelBack", "dimeBack", "quarterBack", "halfdollarBack"]
    
    //MARK: - Table Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let selectedCoin = coinArray[indexPath.row]
        cell.textLabel!.text = selectedCoin
        cell.imageView?.image = UIImage(named: coinFrontImageArray[indexPath.row])
        if let currentCoin = coinFaces.coinFront {
            if currentCoin.containsString(selectedCoin.lowercaseString) {
                cell.backgroundColor = UIColor.lightGrayColor()
            } else {
                cell.backgroundColor = UIColor.whiteColor()
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        coinFront = coinFrontImageArray[indexPath.row]
        coinBack = coinBackImageArray[indexPath.row]
        setFront(coinFront)
        setBack(coinBack)
        
        print("picked coin face: \(coinFaces.coinFront)")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Interactivity Method
    
    func setFront(front: String) -> String {
        coinFaces.coinFront = front
        print("picked coin face: \(coinFaces.coinFront)")
        return coinFaces.coinFront
    }
    
    func setBack (back: String) -> String {
        coinFaces.coinBack = back
        return coinFaces.coinBack
    }
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("picked coin face: \(coinFaces.coinFront)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
