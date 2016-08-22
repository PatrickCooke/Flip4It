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
    let coinFaces = Coin()
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
        //cell.imageView?.image = UIImage(named: coinFrontImageArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        coinFaces.coinFront = coinFrontImageArray[indexPath.row]
        coinFaces.coinBack = coinBackImageArray[indexPath.row]
        coinFront = coinFrontImageArray[indexPath.row]
        coinBack = coinBackImageArray[indexPath.row]
        print("picked coin face: \(coinFront)")
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "coin", object: nil))
    }
    
    //MARK: - Interactivity Method
    
    func setCoin () {
        
    }
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
