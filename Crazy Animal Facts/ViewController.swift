//
//  ViewController.swift
//  Crazy Animal Facts
//
//  Created by Xiran Ou on 1/7/16.
//  Copyright © 2016 Xiran Ou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var randomHeaderLabel: UILabel!
    @IBOutlet weak var crazyFactsLabel: UILabel!
    @IBOutlet weak var factsLabel: UILabel!
    @IBOutlet weak var factButton: UIButton!
    
    let banner = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    
    let factForBanner = RandomFacts()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayBanner(hidden: false,x: 182,y: 325,width: 300,height: 125,banner: banner)
    
        //add fact label over the banner
        label.frame = CGRect(x: 0, y: 0, width: banner.frame.size.width, height: banner.frame.size.height - 50)
        label.font = UIFont(name: "Baskerville-Bold", size: 17)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .Center
        label.numberOfLines = 0
        banner.addSubview(label)
        
        self.label.text = self.factForBanner.randomFact()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        factButton.center.y += 30.0
        factButton.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        randomHeaderLabel.center.x += view.bounds.width
        crazyFactsLabel.center.x -= view.bounds.width

        
        UIView.animateWithDuration(0.7, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.randomHeaderLabel.center.x -= self.view.bounds.width}, completion: nil)
        
        UIView.animateWithDuration(0.9, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.crazyFactsLabel.center.x += self.view.bounds.width}, completion: nil)
        
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.factButton.center.y -= 30.0
            self.factButton.alpha = 1.0
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func factButtonPressed(sender: AnyObject) {
        let bounds = self.factButton.bounds
        UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: [], animations: {
            self.factButton.bounds = CGRect(x: bounds.origin.x-20, y: bounds.origin.y, width: bounds.size.width + 30, height: bounds.size.height + 10)
            }, completion: {_ in
                self.showFact()
                self.factButton.bounds = CGRect(x: bounds.origin.x-20, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
        })
    }
    
    func displayBanner(hidden hidden: Bool, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, banner: UIImageView) {
        banner.hidden = hidden
        banner.center.x = x
        banner.center.y = y
        banner.frame.size.width = width
        banner.frame.size.height = height
        view.addSubview(banner)
    }
    
    func showFact() {
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            self.banner.center.x += self.view.bounds.width
            }, completion: {_ in
                self.label.text = self.factForBanner.randomFact()
                self.banner.hidden = true
                self.banner.center.x -= self.view.bounds.width
                
                UIView.transitionWithView(self.banner, duration: 0.3, options: [.CurveEaseOut, UIViewAnimationOptions.TransitionFlipFromTop], animations: {
                    self.banner.hidden = false
                    }, completion: nil)
            })
    }

}

